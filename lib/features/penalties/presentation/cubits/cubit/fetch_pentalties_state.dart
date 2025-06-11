part of 'fetch_pentalties_cubit.dart';

sealed class FetchPentaltiesState {}

final class FetchPentaltiesInitial extends FetchPentaltiesState {}

final class FetchPentaltiesLoading extends FetchPentaltiesState {}

final class FetchPentaltiesSuccess extends FetchPentaltiesState {
  final List<PenaltyEntity> penalties;

  FetchPentaltiesSuccess({required this.penalties});
}

final class FetchPentaltiesFailure extends FetchPentaltiesState {
  final String message;

  FetchPentaltiesFailure({required this.message});
}
