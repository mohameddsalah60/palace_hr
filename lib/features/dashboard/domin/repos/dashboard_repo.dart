import 'package:dartz/dartz.dart';
import 'package:palace_hr/core/errors/api_error_model.dart';
import 'package:palace_hr/features/auth/domin/entites/user_entity.dart';

import '../../../requests/domin/entites/request_user_input_entity.dart';

abstract class DashboardRepo {
  Future<Either<ApiErrorModel, List<UserEntity>>> fetchAllEmployees();
  Future<Either<ApiErrorModel, List<RequestUserInputEntity>>>
  fetchAllRequests();
  Future<Either<ApiErrorModel, void>> approveRequest({
    required RequestUserInputEntity request,
  });
  Future<Either<ApiErrorModel, void>> rejectRequest({
    required RequestUserInputEntity request,
  });
}
