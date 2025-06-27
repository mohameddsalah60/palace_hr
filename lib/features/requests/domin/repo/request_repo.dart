import 'package:dartz/dartz.dart';
import 'package:palace_hr/core/errors/api_error_model.dart';

import '../entites/request_user_input_entity.dart';

abstract class RequestRepo {
  Future<Either<ApiErrorModel, void>> createRequest({
    required RequestUserInputEntity requestUserInputEntity,
  });
  Future<Either<ApiErrorModel, List<RequestUserInputEntity>>>
  fetchUserRequest();

  Future<Either<ApiErrorModel, void>> cancelRequest({
    required RequestUserInputEntity request,
  });
}
