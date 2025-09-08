part of 'fetch_employe_attendance_cubit.dart';

sealed class FetchEmployeAttendanceState {}

final class FetchEmployeAttendanceInitial extends FetchEmployeAttendanceState {}

final class FetchEmployeAttendanceLoading extends FetchEmployeAttendanceState {}

final class FetchEmployeAttendanceSuccsess extends FetchEmployeAttendanceState {
  final List<AttendanceEntity> attendance;

  FetchEmployeAttendanceSuccsess({required this.attendance});
}

final class FetchEmployeAttendanceFailure extends FetchEmployeAttendanceState {
  final String message;

  FetchEmployeAttendanceFailure({required this.message});
}
