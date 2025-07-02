import 'package:dartz/dartz.dart';
import 'package:palace_hr/core/errors/api_error_model.dart';

abstract class LogOutUserRepo {
  Future<Either<ApiErrorModel, void>> logoutUser();
}
