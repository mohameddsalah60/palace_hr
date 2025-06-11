part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeStateInitial extends HomeState {}

final class HomeStateLoading extends HomeState {}

final class HomeStateFailure extends HomeState {
  final String message;
  HomeStateFailure({required this.message});
}

final class HomeStateSuccess extends HomeState {
  final SchedulesEntity schedules;
  HomeStateSuccess({required this.schedules});
}

final class HomeStateAttendanceSuccess extends HomeState {}
