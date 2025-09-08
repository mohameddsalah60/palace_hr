import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/dashboard/domin/repos/dashboard_repo.dart';

import '../../../../home/domin/entites/attendance_entity.dart';

part 'fetch_employe_attendance_state.dart';

class FetchEmployeAttendanceCubit extends Cubit<FetchEmployeAttendanceState> {
  FetchEmployeAttendanceCubit(this.dashboardRepo)
    : super(FetchEmployeAttendanceInitial());
  final DashboardRepo dashboardRepo;
  String? email;
  fetchEmployeAttendance({required String employeeEmail}) async {
    emit(FetchEmployeAttendanceLoading());
    email = employeeEmail;
    final result = await dashboardRepo.fetchEmployeAttendance(
      email: employeeEmail,
    );
    result.fold(
      (failure) {
        emit(FetchEmployeAttendanceFailure(message: failure.errMessage));
      },
      (attendance) {
        emit(FetchEmployeAttendanceSuccsess(attendance: attendance));
      },
    );
  }

  controlAttendanceUser({
    required String type,
    required AttendanceEntity attendance,
  }) async {
    emit(FetchEmployeAttendanceLoading());
    final result = await dashboardRepo.controlAttendanceUser(
      email: email!,
      type: type,
      attendance: attendance,
    );
    result.fold(
      (failure) {
        emit(FetchEmployeAttendanceFailure(message: failure.errMessage));
      },
      (attendance) {
        fetchEmployeAttendance(employeeEmail: email!);
      },
    );
  }
}
