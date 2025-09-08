import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:palace_hr/core/errors/api_error_model.dart';
import 'package:palace_hr/core/networking/auth_service.dart';
import 'package:palace_hr/core/networking/database_service.dart';
import 'package:palace_hr/features/auth/data/models/user_model.dart';

import 'package:palace_hr/features/auth/domin/entites/user_entity.dart';
import 'package:palace_hr/features/home/data/models/attendance_model.dart';
import 'package:palace_hr/features/home/domin/entites/attendance_entity.dart';
import 'package:palace_hr/features/requests/domin/entites/request_user_input_entity.dart';

import '../../../../core/errors/api_error_handler.dart';
import '../../../../core/networking/constants_database_path.dart';
import '../../../home/data/models/schedules_model.dart';
import '../../../home/domin/entites/schedules_entity.dart';
import '../../../penalties/data/models/penalty_model.dart';
import '../../../penalties/domin/entites/penalty_entity.dart';
import '../../../requests/data/models/request_user_input_model.dart';
import '../../domin/repos/dashboard_repo.dart';

class DashboardRepoImpl implements DashboardRepo {
  final DatabaseService databaseService;
  final AuthService authService;

  DashboardRepoImpl({required this.databaseService, required this.authService});
  @override
  Future<Either<ApiErrorModel, List<UserEntity>>> fetchAllEmployees() async {
    try {
      final result = await databaseService.getData(
        path: ConstantsDatabasePath.getUserData,
      );

      List<UserEntity> users = [];

      if (result is List) {
        users =
            result
                .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
                .toList();
      }
      log(users.toString());
      return right(users);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<ApiErrorModel, List<RequestUserInputEntity>>> fetchRequests({
    String? email,
  }) async {
    try {
      dynamic result;
      if (email == null) {
        result = await databaseService.getCollectionGroup(
          path: ConstantsDatabasePath.addUserRequest,
        );
      } else {
        result = await databaseService.getData(
          path: ConstantsDatabasePath.getUserData,
          uId: email,
          subPath: ConstantsDatabasePath.addUserRequest,
        );
      }
      List<RequestUserInputEntity> requests = [];

      if (result is QuerySnapshot) {
        requests =
            result.docs
                .map<RequestUserInputEntity>(
                  (d) => RequestUserInputModel.fromJson(
                    d.data() as Map<String, dynamic>..['id'] = d.id,
                  ),
                )
                .toList();
      } else if (result is List<Map<String, dynamic>>) {
        requests =
            result
                .map<RequestUserInputEntity>(
                  (d) => RequestUserInputModel.fromJson(d),
                )
                .toList();
      }
      log('Total Requests: ${requests.length}');
      return right(requests);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> approveRequest({
    required RequestUserInputEntity request,
  }) async {
    try {
      if (request.requestStatus == 'approved') {
        return left(ApiErrorModel(errMessage: 'Request already approved'));
      }
      request.requestStatus = 'approved';
      Map<String, dynamic> requestModel =
          RequestUserInputModel.fromEntity(request).toMap();

      await databaseService.addData(
        data: requestModel,
        path: ConstantsDatabasePath.getUserData,
        docId: request.requestUserEmail,
        subPath: ConstantsDatabasePath.addUserRequest,
        subPathDocId:
            "${request.requestType}-${request.requestDateDay!.year}-${request.requestDateDay!.month}-${request.requestDateDay!.day}",
      );

      await saveUserInputChanges(request);

      return right(null);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handleError(e));
    }
  }

  Future<SchedulesEntity> getUserSchedule(
    RequestUserInputEntity request,
  ) async {
    final formattedMonth =
        "${request.requestDateDay!.year.toString()}-${request.requestDateDay!.month.toString()}";
    final result = await databaseService.getData(
      path: ConstantsDatabasePath.getUserData,
      uId: request.requestUserEmail,
      subPath: ConstantsDatabasePath.getUserSchedule,
      subPathId: formattedMonth,
    );

    return SchedulesModel.fromJson(result);
  }

  saveUserInputChanges(RequestUserInputEntity request) async {
    SchedulesEntity schedule = await getUserSchedule(request);
    DayEntity dayEntity = schedule.getScheduleToday(
      date: request.requestDateDay,
    );
    log(dayEntity.day.toString());
    if (request.requestType == 'Annoul Leave') {
      dayEntity.isOffDay = true;
      await databaseService.addData(
        data: SchedulesModel(days: schedule.days).toJson(),
        path: ConstantsDatabasePath.getUserData,
        docId: request.requestUserEmail,
        subPath: ConstantsDatabasePath.getUserSchedule,
        subPathDocId:
            "${request.requestDateDay!.year}-${request.requestDateDay!.month}",
      );
    } else if (request.requestType == 'Permissions') {
      final from = request.requestFromDate!;
      final to = request.requestToDate!;
      final originalStart = dayEntity.times['start']!;
      final originalEnd = dayEntity.times['end']!;

      log("originalStart: $originalStart");
      log("originalEnd: $originalEnd");
      log("from: $from");
      log("to: $to");

      if (isSameHourAndMinute(from, originalStart) ||
          (from.isAfter(originalStart) &&
              to.isBefore(originalEnd) &&
              from.difference(originalStart).inMinutes < 60)) {
        dayEntity.times['start'] = to;
        log("✅ Permission updated start to: $to");
      } else if (isSameHourAndMinute(to, originalEnd) ||
          (to.isBefore(originalEnd) &&
              originalEnd.difference(to).inMinutes < 60)) {
        dayEntity.times['end'] = from;
        log("✅ Permission updated end to: $from");
      } else {
        log("⚠️ Permission doesn't affect start or end time.");
      }

      await databaseService.addData(
        data: SchedulesModel(days: schedule.days).toJson(),
        path: ConstantsDatabasePath.getUserData,
        docId: request.requestUserEmail,
        subPath: ConstantsDatabasePath.getUserSchedule,
        subPathDocId:
            "${request.requestDateDay!.year}-${request.requestDateDay!.month}",
      );
    }
  }

  bool isSameHourAndMinute(DateTime a, DateTime b) {
    return a.hour == b.hour && a.minute == b.minute;
  }

  @override
  Future<Either<ApiErrorModel, void>> rejectRequest({
    required RequestUserInputEntity request,
  }) async {
    try {
      if (request.requestStatus == 'rejected') {
        return left(ApiErrorModel(errMessage: 'Request already rejected'));
      }
      final getUserInformation = await databaseService.getData(
        path: ConstantsDatabasePath.getUserData,
        uId: request.requestUserEmail,
      );
      UserEntity userProfile = UserModel.fromJson(getUserInformation);

      request.requestStatus = 'rejected';
      Map<String, dynamic> requestModel =
          RequestUserInputModel.fromEntity(request).toMap();
      if (request.requestType == 'Annoul Leave') {
        if (userProfile.countAnnualDays < 22) {
          userProfile.countAnnualDays = (userProfile.countAnnualDays) + 1;
        }
        await databaseService.addData(
          data: UserModel.fromEntity(userProfile).toJson(),
          path: ConstantsDatabasePath.getUserData,
          docId: request.requestUserEmail,
        );
      } else if (request.requestType == 'Permissions') {
        if (userProfile.countPermission < 3) {
          userProfile.countPermission = (userProfile.countPermission) + 1;
        }
        await databaseService.addData(
          data: UserModel.fromEntity(userProfile).toJson(),
          path: ConstantsDatabasePath.getUserData,
          docId: request.requestUserEmail,
        );
      }
      //[log] [cloud_firestore/unavailable] The service is currently unavailable. This is a most likely a transient condition and may be corrected by retrying with a backoff.
      await databaseService.addData(
        data: requestModel,
        path: ConstantsDatabasePath.getUserData,
        docId: request.requestUserEmail,
        subPath: ConstantsDatabasePath.addUserRequest,
        subPathDocId:
            "${request.requestType}-${request.requestDateDay!.year}-${request.requestDateDay!.month}-${request.requestDateDay!.day}",
      );
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> setScheduleUser({
    required DayEntity day,
    required String email,
    bool applyToMonth = false,
  }) async {
    try {
      final now = DateTime.now();
      final formattedMonth = "${now.year}-${now.month}";

      final existingDoc = await databaseService.getData(
        path: ConstantsDatabasePath.getUserData,
        uId: email,
        subPath: ConstantsDatabasePath.getUserSchedule,
        subPathId: formattedMonth,
      );

      List<DayModel> existingDays = [];

      if (existingDoc != null && existingDoc is Map<String, dynamic>) {
        final model = SchedulesModel.fromJson(existingDoc);
        existingDays =
            model.days
                .map(
                  (e) => DayModel(
                    day: e.day,
                    times: Map<String, DateTime>.from(e.times),
                    isOffDay: e.isOffDay,
                  ),
                )
                .toList();
      }

      if (applyToMonth) {
        final startTime = day.times["start"];
        final endTime = day.times["end"];

        final totalDays = _daysInMonth(now);

        existingDays = List.generate(totalDays, (i) {
          final dayNum = i + 1;

          final newStart = DateTime(
            now.year,
            now.month,
            dayNum,
            startTime!.hour,
            startTime.minute,
          );
          final newEnd = DateTime(
            now.year,
            now.month,
            dayNum,
            endTime!.hour,
            endTime.minute,
          );

          return DayModel(
            day: dayNum,
            times: {"start": newStart, "end": newEnd},
            isOffDay:
                existingDays
                    .firstWhere(
                      (d) => d.day == dayNum,
                      orElse:
                          () =>
                              DayModel(day: dayNum, times: {}, isOffDay: false),
                    )
                    .isOffDay,
          );
        });
      } else {
        final dayIndex = existingDays.indexWhere((d) => d.day == day.day);
        if (dayIndex != -1) {
          final startTime = day.times["start"];
          final endTime = day.times["end"];

          final newStart = DateTime(
            now.year,
            now.month,
            day.day,
            startTime!.hour,
            startTime.minute,
          );
          final newEnd = DateTime(
            now.year,
            now.month,
            day.day,
            endTime!.hour,
            endTime.minute,
          );

          existingDays[dayIndex] = DayModel(
            day: day.day,
            times: {"start": newStart, "end": newEnd},
            isOffDay: day.isOffDay,
          );
        } else {
          final startTime = day.times["start"];
          final endTime = day.times["end"];

          final newStart = DateTime(
            now.year,
            now.month,
            day.day,
            startTime!.hour,
            startTime.minute,
          );
          final newEnd = DateTime(
            now.year,
            now.month,
            day.day,
            endTime!.hour,
            endTime.minute,
          );

          existingDays.add(
            DayModel(
              day: day.day,
              times: {"start": newStart, "end": newEnd},
              isOffDay: day.isOffDay,
            ),
          );
        }
      }

      await databaseService.addData(
        data: SchedulesModel(days: existingDays).toJson(),
        path: ConstantsDatabasePath.getUserData,
        docId: email,
        subPath: ConstantsDatabasePath.getUserSchedule,
        subPathDocId: formattedMonth,
      );

      return right(null);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handleError(e));
    }
  }

  int _daysInMonth(DateTime date) {
    final firstDayNextMonth =
        (date.month < 12)
            ? DateTime(date.year, date.month + 1, 1)
            : DateTime(date.year + 1, 1, 1);
    return firstDayNextMonth.subtract(const Duration(days: 1)).day;
  }

  @override
  Future<Either<ApiErrorModel, List<AttendanceEntity>>> fetchEmployeAttendance({
    required String email,
  }) async {
    try {
      final result = await databaseService.getData(
        path: ConstantsDatabasePath.getUserData,
        uId: email,
        subPath: ConstantsDatabasePath.getUserAttendence,
        query: {
          'orderBy': 'dateTime',
          'descending': false,
          'whereRange': {
            'field': 'dateTime',
            'isGreaterThanOrEqualTo': DateTime(
              DateTime.now().year,
              DateTime.now().month,
              1,
            ),
            'isLessThan': DateTime(
              DateTime.now().year,
              DateTime.now().month + 1,
              0,
            ),
          },
        },
      );

      List<AttendanceEntity> requests =
          (result as List<Map<String, dynamic>>)
              .map<AttendanceEntity>((d) => AttendanceModel.fromJson(d))
              .toList();
      log('Total Requests: ${requests.length}');
      return right(requests);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<ApiErrorModel, List<PenaltyEntity>>> fetchUserPenalty({
    DateTime? sort,
    required String email,
  }) async {
    try {
      List<PenaltyEntity> penalties = [];
      DateTime sortedStartDate = DateTime(
        sort?.year ?? DateTime.now().year,
        sort?.month ?? DateTime.now().month,
        1,
      );

      DateTime sortedEndDate = DateTime(
        sort?.month == 12
            ? (sort?.year ?? DateTime.now().year) + 1
            : (sort?.year ?? DateTime.now().year),
        sort?.month == 12 ? 1 : (sort?.month ?? DateTime.now().month) + 1,
        1,
      );
      var response = await databaseService.getData(
        path: ConstantsDatabasePath.getUserData,
        uId: email,
        subPath: ConstantsDatabasePath.getUserMyPenalties,
        query: {
          'orderBy': 'date',
          'descending': false,
          'whereRange': {
            'field': 'date',
            'isGreaterThanOrEqualTo': sortedStartDate,
            'isLessThan': sortedEndDate,
          },
        },
      );
      for (var i in response) {
        PenaltyEntity penaltyEntity = PenaltyModel.fromJson(i);
        penalties.add(penaltyEntity);
      }
      log(penalties.toString());
      return right(penalties);
    } catch (e) {
      log(e.toString());

      return left(
        ServerFailure(errMessage: ApiErrorHandler.handleError(e).errMessage),
      );
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> controlAttendanceUser({
    required String email,
    required String type,
    required AttendanceEntity attendance,
  }) async {
    try {
      if (type == 'cancelCheckin') {
        await databaseService.deleteData(
          path: ConstantsDatabasePath.getUserData,
          uId: email,
          subPath: ConstantsDatabasePath.getUserAttendence,
          subPathId:
              "${attendance.dateTime.year}-${attendance.dateTime.month.toString().padLeft(2, '0')}-${attendance.dateTime.day.toString().padLeft(2, '0')}",
        );
      } else if (type == 'cancelCheckout') {
        attendance.checkOut = null;
        await databaseService.addData(
          data: AttendanceModel.fromEntity(attendance).toJson(),
          path: ConstantsDatabasePath.getUserData,
          docId: email,
          subPath: ConstantsDatabasePath.getUserAttendence,
          subPathDocId:
              "${attendance.dateTime.year}-${attendance.dateTime.month.toString().padLeft(2, '0')}-${attendance.dateTime.day.toString().padLeft(2, '0')}",
        );
      }

      return right(null);
    } catch (e) {
      log(e.toString());
      return left(ApiErrorHandler.handleError(e));
    }
  }
}
