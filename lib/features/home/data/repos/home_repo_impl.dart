import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:palace_hr/core/errors/api_error_model.dart';
import 'package:palace_hr/core/helpers/get_user.dart';
import 'package:palace_hr/core/networking/constants_database_path.dart';
import 'package:palace_hr/core/networking/database_service.dart';
import 'package:palace_hr/core/networking/location_service.dart';
import 'package:palace_hr/core/networking/storage_service.dart';
import 'package:palace_hr/features/home/data/models/attendance_model.dart';
import 'package:palace_hr/features/home/domin/entites/attendance_entity.dart';
import 'package:palace_hr/features/home/domin/entites/schedules_entity.dart';
import 'package:palace_hr/features/penalties/app/penalty_handler.dart';

import '../../../../core/errors/api_error_handler.dart';
import '../../../../core/errors/errors_messages.dart';
import '../../domin/repos/home_repo.dart';
import '../helpers/home_utils.dart';
import '../models/schedules_model.dart';

class HomeRepoImpl implements HomeRepo {
  final StorageService storageService;
  final DatabaseService databaseService;
  final LocationService locationService;
  final PenaltyHandler penaltyHandler;
  HomeRepoImpl({
    required this.locationService,
    required this.storageService,
    required this.databaseService,
    required this.penaltyHandler,
  });

  @override
  Future<Either<ApiErrorModel, AttendanceEntity>> onCheckIn({
    required AttendanceEntity attendanceEntity,
    required Uint8List photo,
  }) async {
    try {
      if (!HomeUtils.validateShiftStart(attendanceEntity.dateTime)) {
        return left(ServerFailure(errMessage: ErrorMessages.tooEarlyForShift));
      } else if (!HomeUtils.validateShiftNotExpired(
        attendanceEntity.dateTime,
      )) {
        return left(
          ServerFailure(errMessage: ErrorMessages.outsideWorkingHours),
        );
      }

      final location = await locationService.getCurrentPosition();
      final isInsideArea = await locationService.checkUserIfInsideArea(
        location: location,
      );
      if (!isInsideArea) {
        return left(
          ServerFailure(errMessage: ErrorMessages.outsideWorkingArea),
        );
      }

      final existingAttendance = await getAttendanceIfExists(
        path: attendanceEntity.dateTime,
      );
      if (existingAttendance != null) {
        return left(ServerFailure(errMessage: ErrorMessages.alreadyCheckedIn));
      }

      await _checkInYesterday(attendanceEntity.dateTime);
      await penaltyHandler.handleDelayPenalty(attendanceEntity.dateTime);

      final attendanceModel = AttendanceModel.fromEntity(attendanceEntity);
      attendanceModel.location['lat'] = location.latitude;
      attendanceModel.location['long'] = location.longitude;

      await HomeUtils.addData(
        databaseService: databaseService,
        data: attendanceModel.toJson(),
        docId: getUser().email,
        subPath: ConstantsDatabasePath.getUserAttendence,
        subPathDocId: HomeUtils.formatDate(attendanceEntity.dateTime),
      );

      return right(attendanceEntity);
    } catch (e) {
      return left(ApiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<ApiErrorModel, AttendanceEntity>> onCheckOut({
    required DateTime dateTime,
    required Uint8List photo,
  }) async {
    try {
      if (!HomeUtils.validateShiftNotExpired(dateTime)) {
        return left(
          ServerFailure(errMessage: ErrorMessages.outsideWorkingHours),
        );
      }
      final now = DateTime.now();
      final location = await locationService.getCurrentPosition();
      final isInsideArea = await locationService.checkUserIfInsideArea(
        location: location,
      );
      if (!isInsideArea) {
        return left(
          ServerFailure(errMessage: ErrorMessages.outsideWorkingArea),
        );
      }

      final existingAttendance = await getAttendanceIfExists(path: dateTime);
      if (existingAttendance == null) {
        return left(ServerFailure(errMessage: ErrorMessages.notCheckedIn));
      } else if (existingAttendance.checkOut != null) {
        return left(ServerFailure(errMessage: ErrorMessages.alreadyCheckedOut));
      } else if (dateTime.isBefore(now)) {
        return left(
          ServerFailure(errMessage: ErrorMessages.insideWorkingHours),
        );
      }

      existingAttendance.checkOut = "${now.hour}:${now.minute}:${now.second}";

      await HomeUtils.addData(
        databaseService: databaseService,
        data: existingAttendance.toJson(),
        docId: getUser().email,
        subPath: ConstantsDatabasePath.getUserAttendence,
        subPathDocId: HomeUtils.formatDate(existingAttendance.dateTime),
      );

      return right(existingAttendance);
    } catch (e) {
      return left(ApiErrorHandler.handleError(e));
    }
  }

  @override
  Future<AttendanceModel?> getAttendanceIfExists({
    required DateTime path,
  }) async {
    final subPathId = HomeUtils.formatDate(path);
    final exists = await databaseService.checkIfDataExists(
      path: ConstantsDatabasePath.getUserData,
      docId: getUser().email,
      subPath: ConstantsDatabasePath.getUserAttendence,
      subPathId: subPathId,
    );
    if (!exists) return null;

    final data = await HomeUtils.getData(
      databaseService: databaseService,
      path: ConstantsDatabasePath.getUserData,
      docId: getUser().email,
      subPath: ConstantsDatabasePath.getUserAttendence,
      subPathId: subPathId,
    );
    return AttendanceModel.fromJson(data!);
  }

  Future<void> _checkInYesterday(DateTime date) async {
    final DateTime yesterday = date.subtract(const Duration(days: 1));
    final String subPathId = HomeUtils.formatDate(yesterday);

    final exists = await databaseService.checkIfDataExists(
      path: ConstantsDatabasePath.getUserData,
      docId: getUser().email,
      subPath: ConstantsDatabasePath.getUserAttendence,
      subPathId: subPathId,
    );

    if (!exists) {
      final scheduleData = await HomeUtils.getData(
        databaseService: databaseService,
        path: ConstantsDatabasePath.getUserData,
        docId: getUser().email,
        subPath: ConstantsDatabasePath.getUserSchedule,
        subPathId: "${date.year}-${date.month.toString().padLeft(2, '0')}",
      );

      SchedulesEntity schedulesModel = SchedulesModel.fromJson(scheduleData!);
      final day = schedulesModel.days.firstWhere(
        (d) => d.day == yesterday.day,
        orElse:
            () => DayModel(
              day: yesterday.day,
              times: {"start": DateTime.now(), "end": DateTime.now()},
              isOffDay: false,
            ),
      );

      if (!day.isOffDay && day.times['start'] != DateTime.now()) {
        await penaltyHandler.handleAbsentPenalty(yesterday);
      }
    }
  }
}
