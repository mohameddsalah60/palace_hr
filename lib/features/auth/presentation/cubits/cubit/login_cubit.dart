import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/auth/domin/repos/auth_repo.dart';

import '../../../../../core/helpers/app_regex.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthRepo authRepo;
  bool isObscure = true;
  void togglePasswordVisibility() {
    isObscure = !isObscure;
    emit(LoginInitial());
  }

  Future<void> signInWithEmailAndPassword() async {
    emit(LoginLoading());
    var result = await authRepo.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    result.fold(
      (l) => emit(LoginError(l.errMessage)),
      (r) => emit(LoginSuccess()),
    );
  }

  String? validatorPassword(value) {
    if (value == null || value.isEmpty) {
      return 'This field password number is required.';
    } else if (!AppRegex.isPasswordValid(value)) {
      return 'Please enter a valid password.';
    }
    return null;
  }

  String? validatorEmail(value) {
    if (value == null || value.isEmpty) {
      return 'This field email is required.';
    } else if (!AppRegex.isEmailValid(value)) {
      return 'Please enter a valid email address.';
    } else if (!value.contains('@palace.com')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    passwordController.removeListener(() {});
    return super.close();
  }
}
