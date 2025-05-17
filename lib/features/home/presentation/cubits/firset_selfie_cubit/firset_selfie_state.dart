part of 'firset_selfie_cubit.dart';

sealed class FirsetSelfieState {}

final class FirsetSelfieInitial extends FirsetSelfieState {}

final class FirsetSelfieLoading extends FirsetSelfieState {}

final class FirsetSelfieFailure extends FirsetSelfieState {
  final String message;

  FirsetSelfieFailure(this.message);
}

final class FirsetSelfieSuccess extends FirsetSelfieState {}
