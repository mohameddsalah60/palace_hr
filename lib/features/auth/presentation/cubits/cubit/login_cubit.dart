import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/auth/domin/repos/auth_repo.dart';

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

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    passwordController.removeListener(() {});
    return super.close();
  }
}
