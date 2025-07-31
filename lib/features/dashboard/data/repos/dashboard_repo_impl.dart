import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:palace_hr/core/errors/api_error_model.dart';
import 'package:palace_hr/core/networking/auth_service.dart';
import 'package:palace_hr/core/networking/database_service.dart';
import 'package:palace_hr/features/auth/data/models/user_model.dart';

import 'package:palace_hr/features/auth/domin/entites/user_entity.dart';
import 'package:palace_hr/features/requests/domin/entites/request_user_input_entity.dart';

import '../../../../core/errors/api_error_handler.dart';
import '../../../../core/networking/constants_database_path.dart';
import '../../../home/data/models/schedules_model.dart';
import '../../../home/domin/entites/schedules_entity.dart';
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
  Future<Either<ApiErrorModel, List<RequestUserInputEntity>>>
  fetchAllRequests() async {
    try {
      final result = await databaseService.getCollectionGroup(
        path: ConstantsDatabasePath.addUserRequest,
      );
      List<RequestUserInputEntity> requests =
          result.docs
              .map<RequestUserInputEntity>(
                (d) => RequestUserInputModel.fromJson(d.data()..['id'] = d.id),
              )
              .toList();
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
      UserEntity USER_PROFILE = UserModel.fromJson(getUserInformation);

      request.requestStatus = 'rejected';
      Map<String, dynamic> requestModel =
          RequestUserInputModel.fromEntity(request).toMap();
      if (request.requestType == 'Annoul Leave') {
        if (USER_PROFILE.countAnnualDays < 22) {
          USER_PROFILE.countAnnualDays = (USER_PROFILE.countAnnualDays) + 1;
        }
        await databaseService.addData(
          data: UserModel.fromEntity(USER_PROFILE).toJson(),
          path: ConstantsDatabasePath.getUserData,
          docId: request.requestUserEmail,
        );
      } else if (request.requestType == 'Permissions') {
        if (USER_PROFILE.countPermission < 3) {
          USER_PROFILE.countPermission = (USER_PROFILE.countPermission) + 1;
        }
        await databaseService.addData(
          data: UserModel.fromEntity(USER_PROFILE).toJson(),
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
}
