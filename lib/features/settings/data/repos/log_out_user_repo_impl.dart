import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:palace_hr/core/errors/api_error_model.dart';
import 'package:palace_hr/core/networking/constants_database_path.dart';
import 'package:palace_hr/core/services/shared_preferences_service.dart';

import '../../../../core/errors/api_error_handler.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/networking/auth_service.dart';
import '../../domin/repos/log_out_user_repo.dart';

class LogOutUserRepoImpl implements LogOutUserRepo {
  final AuthService authService;

  LogOutUserRepoImpl({required this.authService});
  @override
  Future<Either<ApiErrorModel, void>> logoutUser() async {
    try {
      await authService.signOut();
      removeUserDataSaved();
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    } catch (e) {
      log(e.toString());
      return left(
        ServerFailure(errMessage: ApiErrorHandler.handleError(e).errMessage),
      );
    }
  }

  removeUserDataSaved() {
    SharedPreferencesService.remove(ConstantsDatabasePath.userDataLocalStorage);
  }
}
