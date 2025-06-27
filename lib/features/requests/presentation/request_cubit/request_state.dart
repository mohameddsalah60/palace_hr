part of 'request_cubit.dart';

sealed class RequestState {}

final class RequestInitial extends RequestState {}

final class RequestTypePermissionState extends RequestState {}

final class RequestSuccessState extends RequestState {}

final class RequestLoadingState extends RequestState {}

final class RequestErrorState extends RequestState {
  final String message;

  RequestErrorState(this.message);
}
