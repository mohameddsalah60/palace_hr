part of 'fetch_employees_cubit.dart';

sealed class FetchEmployeesState {}

final class FetchEmployeesInitial extends FetchEmployeesState {}

final class FetchEmployeesLoading extends FetchEmployeesState {}

final class FetchEmployeesSuccess extends FetchEmployeesState {
  final List<UserEntity> users;

  FetchEmployeesSuccess({required this.users});
}

final class FetchEmployeesEmpty extends FetchEmployeesState {}

final class FetchEmployeesFailure extends FetchEmployeesState {
  final String message;

  FetchEmployeesFailure({required this.message});
}
