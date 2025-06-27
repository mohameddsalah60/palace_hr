part of 'fetch_requests_cubit.dart';

sealed class FetchRequestsState {}

final class FetchRequestsInitial extends FetchRequestsState {}

final class FetchRequestsLoading extends FetchRequestsState {}

final class FetchRequestsSuccess extends FetchRequestsState {
  List<RequestUserInputEntity> requests;
  FetchRequestsSuccess({this.requests = const []});
}

final class FetchRequestsFailure extends FetchRequestsState {
  final String message;

  FetchRequestsFailure({required this.message});
}

final class FetchRequestsEmpty extends FetchRequestsState {
  final String message;

  FetchRequestsEmpty({required this.message});
}
