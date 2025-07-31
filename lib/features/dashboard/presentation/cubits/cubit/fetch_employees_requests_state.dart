part of 'fetch_employees_requests_cubit.dart';

sealed class FetchEmployeesRequestsState {}

final class FetchEmployeesRequestsInitial extends FetchEmployeesRequestsState {}

final class FetchEmployeesRequestsLoading extends FetchEmployeesRequestsState {}

final class FetchEmployeesRequestSuccess extends FetchEmployeesRequestsState {
  final List<RequestUserInputEntity> requests;

  FetchEmployeesRequestSuccess({required this.requests});
}

final class FetchEmployeesRequestsFailure extends FetchEmployeesRequestsState {
  final String message;

  FetchEmployeesRequestsFailure({required this.message});
}
