import 'package:dartz/dartz.dart';
import 'package:palace_hr/core/errors/api_error_model.dart';
import 'package:palace_hr/features/auth/domin/entites/user_entity.dart';
import 'package:palace_hr/features/home/domin/entites/schedules_entity.dart';

import '../../../home/domin/entites/attendance_entity.dart';
import '../../../penalties/domin/entites/penalty_entity.dart';
import '../../../requests/domin/entites/request_user_input_entity.dart';

abstract class DashboardRepo {
  Future<Either<ApiErrorModel, List<UserEntity>>> fetchAllEmployees();
  Future<Either<ApiErrorModel, List<RequestUserInputEntity>>> fetchRequests({
    String? email,
  });
  Future<Either<ApiErrorModel, void>> approveRequest({
    required RequestUserInputEntity request,
  });
  Future<Either<ApiErrorModel, void>> rejectRequest({
    required RequestUserInputEntity request,
  });
  Future<Either<ApiErrorModel, void>> setScheduleUser({
    required DayEntity day,
    required String email,
    bool applyToMonth = false,
  });
  Future<Either<ApiErrorModel, List<AttendanceEntity>>> fetchEmployeAttendance({
    required String email,
  });
  Future<Either<ApiErrorModel, List<PenaltyEntity>>> fetchUserPenalty({
    DateTime? sort,
    required String email,
  });
  Future<Either<ApiErrorModel, void>> controlAttendanceUser({
    required String email,
    required String type,
    required AttendanceEntity attendance,
  });
}
