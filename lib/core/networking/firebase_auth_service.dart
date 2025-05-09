import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../errors/api_error_handler.dart';
import '../errors/exceptions.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!;
    } catch (e) {
      log(e.toString());
      throw CustomException(message: ApiErrorHandler.handleError(e).errMessage);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw CustomException(message: ApiErrorHandler.handleError(e).errMessage);
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    try {
      return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw CustomException(message: ApiErrorHandler.handleError(e).errMessage);
    }
  }
}
