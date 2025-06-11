import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:palace_hr/core/errors/api_error_model.dart';
import 'package:palace_hr/features/home/domin/entites/attendance_entity.dart';

import '../../data/models/attendance_model.dart';

abstract class HomeRepo {
  Future<Either<ApiErrorModel, AttendanceEntity>> onCheckIn({
    required AttendanceEntity attendanceEntity,
    required Uint8List photo,
  });
  Future<Either<ApiErrorModel, AttendanceEntity>> onCheckOut({
    required DateTime dateTime,
    required Uint8List photo,
  });

  Future<AttendanceModel?> getAttendanceIfExists({required DateTime path});
  // Future<void> checkUserDelay({required Duration delay});
}
