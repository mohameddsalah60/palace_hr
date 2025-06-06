import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:palace_hr/core/errors/api_error_handler.dart';
import 'package:palace_hr/core/errors/errors_messages.dart';
import 'package:palace_hr/core/networking/auth_service.dart';
import 'package:palace_hr/core/networking/constants_database_path.dart';
import 'package:palace_hr/core/services/shared_preferences_service.dart';
import 'package:palace_hr/features/auth/domin/repos/auth_repo.dart';

import '../../../../core/errors/api_error_model.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/networking/database_service.dart';
import '../../domin/entites/user_entity.dart';
import '../models/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;
  final DatabaseService databaseService;

  AuthRepoImpl({required this.authService, required this.databaseService});
  @override
  Future<Either<ApiErrorModel, void>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await authService.sendPasswordResetEmail(email: email);
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

  @override
  Future<Either<ApiErrorModel, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      User user = await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var userEntity = await getUserData(user: user);
      return right(userEntity);
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
  Future<UserEntity> getUserData({required User user}) async {
    var userData = await databaseService.getData(
      path: ConstantsDatabasePath.getUserData,
      uId: user.email,
    );
    if (userData != null && userData.isNotEmpty) {
      UserEntity userEntity = UserModel.fromJson(userData);
      userEntity.token = user.uid;
      await saveUserData(userEntity: userEntity);
      addUserData(userEntity: userEntity);
      return userEntity;
    } else {
      throw CustomException(message: ErrorMessages.emailNotFound);
    }
  }

  @override
  Future saveUserData({required UserEntity userEntity}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(userEntity).toMap());
    await SharedPreferencesService.setData(
      key: ConstantsDatabasePath.userDataLocalStorage,
      value: jsonData,
    );
  }

  @override
  Future<void> signOut() async {
    return await authService.signOut();
  }

  @override
  Future addUserData({required UserEntity userEntity}) async {
    await databaseService.addData(
      path: ConstantsDatabasePath.addUserData,
      data: UserModel.fromEntity(userEntity).toMap(),
      docId: userEntity.email,
    );
  }

  @override
  Future<Either<ApiErrorModel, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }
}
