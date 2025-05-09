import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:palace_hr/core/errors/api_error_model.dart';

import '../entites/user_entity.dart';

abstract class AuthRepo {
  Future<Either<ApiErrorModel, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<ApiErrorModel, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserEntity> getUserData({required User user});
  Future<void> saveUserData({required UserEntity userEntity});
  Future<void> addUserData({required UserEntity userEntity});
  Future<void> signOut();

  Future<Either<ApiErrorModel, void>> sendPasswordResetEmail({
    required String email,
  });
}
