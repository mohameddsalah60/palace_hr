part of 'employee_shift_changer_cubit.dart';

sealed class EmployeeShiftChangerState {}

final class EmployeeShiftChangerInitial extends EmployeeShiftChangerState {}

final class EmployeeShiftChangerLoading extends EmployeeShiftChangerState {}

final class EmployeeShiftChangerUpdateUI extends EmployeeShiftChangerState {}

final class EmployeeShiftChangerError extends EmployeeShiftChangerState {
  final String message;

  EmployeeShiftChangerError({required this.message});
}

final class EmployeeShiftChangerSuccess extends EmployeeShiftChangerState {}
