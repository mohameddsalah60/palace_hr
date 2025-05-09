import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/auth/domin/repos/auth_repo.dart';

import '../../../../../core/helpers/app_regex.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.authRepo) : super(ForgetPasswordInitial());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  final AuthRepo authRepo;
  Future<void> sendPasswordResetEmail() async {
    emit(ForgetPasswordLoading());
    var result = await authRepo.sendPasswordResetEmail(
      email: emailController.text,
    );
    result.fold(
      (l) => emit(ForgetPasswordError(l.errMessage)),
      (r) => emit(ForgetPasswordSuccses()),
    );
  }

  String? validatorEmail(value) {
    if (value == null || value.isEmpty) {
      return 'This field email is required.';
    } else if (!AppRegex.isEmailValid(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
