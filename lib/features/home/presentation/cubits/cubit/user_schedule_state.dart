part of 'user_schedule_cubit.dart';

sealed class UserScheduleState {}

final class UserScheduleInitial extends UserScheduleState {}

final class UserScheduleLoading extends UserScheduleState {}

final class UserScheduleFailure extends UserScheduleState {
  final String message;
  UserScheduleFailure({required this.message});
}

final class UserScheduleSuccess extends UserScheduleState {
  final SchedulesEntity schedules;
  UserScheduleSuccess({required this.schedules});
}
