part of 'forget_password_cubit.dart';

sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordSuccses extends ForgetPasswordState {}

final class ForgetPasswordError extends ForgetPasswordState {
  final String error;

  ForgetPasswordError(this.error);
}
