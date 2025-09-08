part of 'fetch_employee_penalties_cubit.dart';

sealed class FetchEmployeePenaltiesState {}

final class FetchEmployeePenaltiesInitial extends FetchEmployeePenaltiesState {}

final class FetchPenaltiesLoading extends FetchEmployeePenaltiesState {}

final class FetchPenaltiesSuccess extends FetchEmployeePenaltiesState {
  final List<PenaltyEntity> penalties;
  FetchPenaltiesSuccess(this.penalties);
}

final class FetchPenaltiesFailure extends FetchEmployeePenaltiesState {
  final String message;
  FetchPenaltiesFailure(this.message);
}
