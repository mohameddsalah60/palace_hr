import 'dart:developer';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import 'package:palace_hr/core/errors/api_error_model.dart';
import 'package:palace_hr/core/errors/exceptions.dart';
import 'package:palace_hr/core/helpers/get_user.dart';
import 'package:palace_hr/core/networking/constants_database_path.dart';
import 'package:palace_hr/core/networking/database_service.dart';
import 'package:palace_hr/core/networking/location_service.dart';
import 'package:palace_hr/core/networking/storage_service.dart';
import 'package:palace_hr/features/home/data/models/attendance_model.dart';
import 'package:palace_hr/features/home/domin/entites/attendance_entity.dart';
import 'package:palace_hr/features/home/domin/entites/schedules_entity.dart';

import '../../../../core/errors/api_error_handler.dart';
import '../../../../core/errors/errors_messages.dart';
import '../../domin/repos/home_repo.dart';
import '../models/schedules_model.dart';

class HomeRepoImpl implements HomeRepo {
  final StorageService storageService;
  final DatabaseService databaseService;
  final LocationService locationService;
  HomeRepoImpl({
    required this.locationService,
    required this.storageService,
    required this.databaseService,
  });

  @override
  Future<Either<ApiErrorModel, SchedulesEntity>> loadUserSchedules({
    required DateTime date,
  }) async {
    try {
      final formattedMonth =
          "${date.year}-${date.month.toString().padLeft(2, '0')}";
      final result = await _getData(
        path: ConstantsDatabasePath.getUserData,
        docId: getUser().email,
        subPath: ConstantsDatabasePath.getUserSchedule,
        subPathId: formattedMonth,
      );
      if (result == null) {
        log("No schedules found for user: ${getUser().email}");
        return left(
          ServerFailure(errMessage: "No schedules found for the user."),
        );
      }

      SchedulesEntity schedules = SchedulesModel.fromJson(result);
      return right(schedules);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    } catch (e) {
      log(e.toString());
      return left(
        ServerFailure(errMessage: ApiErrorHandler.handleError(e).errMessage),
      );
    }
  }

  @override
  Future<Either<ApiErrorModel, AttendanceEntity>> onCheckIn({
    required AttendanceEntity attendanceEntity,
    required Uint8List photo,
  }) async {
    try {
      if (!_isSameDate(attendanceEntity.dateTime, DateTime.now())) {
        return left(
          ServerFailure(errMessage: ErrorMessages.outsideWorkingHours),
        );
      }
      Location location = await locationService.getCurrentPosition();
      bool userIsInsideArea = await locationService.checkUserIfInsideArea(
        location: location,
      );
      if (!userIsInsideArea) {
        return left(
          ServerFailure(errMessage: ErrorMessages.outsideWorkingArea),
        );
      }
      AttendanceModel attendanceModel = AttendanceModel.fromEntity(
        attendanceEntity,
      );

      final existingAttendance = await getAttendanceIfExists(
        path: attendanceEntity.dateTime,
      );

      if (existingAttendance != null) {
        return left(ServerFailure(errMessage: ErrorMessages.alreadyCheckedIn));
      }

      await _checkInYesterday();
      attendanceModel.location['lat'] = location.latitude;
      attendanceModel.location['long'] = location.longitude;
      await _addData(
        data: attendanceModel.toJson(),
        docId: getUser().email,
        subPath: ConstantsDatabasePath.getUserAttendence,
        subPathDocId: _formatDate(attendanceEntity.dateTime),
      );

      return right(attendanceEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    } catch (e) {
      log(e.toString());
      return left(
        ServerFailure(errMessage: ApiErrorHandler.handleError(e).errMessage),
      );
    }
  }

  @override
  Future<Either<ApiErrorModel, AttendanceEntity>> onCheckOut({
    required DateTime dateTime,
    required Uint8List photo,
  }) async {
    try {
      DateTime shiftEnd = dateTime;

      DateTime now = DateTime.now();

      if (shiftEnd.isBefore(now)) {
        return left(
          ServerFailure(errMessage: ErrorMessages.insideWorkingHours),
        );
      }
      Location location = await locationService.getCurrentPosition();
      bool userIsInsideArea = await locationService.checkUserIfInsideArea(
        location: location,
      );
      if (!userIsInsideArea) {
        return left(
          ServerFailure(errMessage: ErrorMessages.outsideWorkingArea),
        );
      }
      final existingAttendance = await getAttendanceIfExists(path: dateTime);

      if (existingAttendance == null) {
        return left(ServerFailure(errMessage: ErrorMessages.notCheckedIn));
      } else if (existingAttendance.checkOut != null &&
          existingAttendance.checkOut!.isNotEmpty) {
        return left(ServerFailure(errMessage: ErrorMessages.alreadyCheckedOut));
      } else {
        DateTime now = DateTime.now();
        existingAttendance.checkOut = "${now.hour}:${now.minute}:${now.second}";

        await _addData(
          data: existingAttendance.toJson(),
          docId: getUser().email,
          subPath: ConstantsDatabasePath.getUserAttendence,
          subPathDocId: _formatDate(existingAttendance.dateTime),
        );
      }

      return right(existingAttendance);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    } catch (e) {
      log(e.toString());
      return left(
        ServerFailure(errMessage: ApiErrorHandler.handleError(e).errMessage),
      );
    }
  }

  bool _isSameDate(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  @override
  Future<AttendanceModel?> getAttendanceIfExists({
    required DateTime path,
  }) async {
    final subPathId = _formatDate(path);
    final exists = await databaseService.checkIfDataExists(
      path: ConstantsDatabasePath.getUserData,
      docId: getUser().email,
      subPath: ConstantsDatabasePath.getUserAttendence,
      subPathId: subPathId,
    );

    if (!exists) return null;

    final data = await _getData(
      path: ConstantsDatabasePath.getUserData,
      docId: getUser().email,
      subPath: ConstantsDatabasePath.getUserAttendence,
      subPathId: subPathId,
    );
    return AttendanceModel.fromJson(data!);
  }

  Future<void> _checkInYesterday() async {
    final DateTime now = DateTime.now();
    final DateTime yesterday = now.subtract(const Duration(days: 1));
    final String subPathId = _formatDate(yesterday);

    final exists = await databaseService.checkIfDataExists(
      path: ConstantsDatabasePath.getUserData,
      docId: getUser().email,
      subPath: ConstantsDatabasePath.getUserAttendence,
      subPathId: subPathId,
    );

    if (!exists) {
      final scheduleData = await _getData(
        path: ConstantsDatabasePath.getUserData,
        docId: getUser().email,
        subPath: ConstantsDatabasePath.getUserSchedule,
        subPathId: "${now.year}-${now.month.toString().padLeft(2, '0')}",
      );

      SchedulesModel schedulesModel = SchedulesModel.fromJson(scheduleData!);
      DayEntity? day = schedulesModel.days.firstWhere(
        (d) => d.day == yesterday.day,
        orElse:
            () => DayModel(
              day: yesterday.day,
              times: {"start": DateTime.now(), "end": DateTime.now()},
              isOffDay: false,
            ),
      );

      if (!day.isOffDay && day.times['start'] != DateTime.now()) {
        log("Add user penalty");
        // TODO: Handle add user penalty
      }
    }
  }

  String _formatDate(DateTime date) =>
      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

  Future<Map<String, dynamic>?> _getData({
    required String path,
    required String docId,
    required String subPath,
    required String subPathId,
  }) async {
    return await databaseService.getData(
      path: path,
      uId: docId,
      subPath: subPath,
      subPathId: subPathId,
    );
  }

  Future<void> _addData({
    required Map<String, dynamic> data,
    required String docId,
    required String subPath,
    required String subPathDocId,
  }) async {
    await databaseService.addData(
      data: data,
      path: ConstantsDatabasePath.getUserData,
      docId: docId,
      subPath: subPath,
      subPathDocId: subPathDocId,
    );
  }
}
