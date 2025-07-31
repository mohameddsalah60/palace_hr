import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/auth/domin/entites/user_entity.dart';
import 'package:palace_hr/features/dashboard/domin/repos/dashboard_repo.dart';

part 'fetch_employees_state.dart';

class FetchEmployeesCubit extends Cubit<FetchEmployeesState> {
  FetchEmployeesCubit(this.dashboardRepo) : super(FetchEmployeesInitial());
  final DashboardRepo dashboardRepo;
  List<UserEntity> users = [];
  Timer? _debounce;

  Future<void> fetchEmployees() async {
    emit(FetchEmployeesLoading());
    var result = await dashboardRepo.fetchAllEmployees();
    result.fold(
      (failure) {
        log(failure.errMessage);
        emit(FetchEmployeesFailure(message: failure.errMessage));
      },
      (emplyees) {
        if (emplyees.isEmpty) {
          emit(FetchEmployeesEmpty());
        } else {
          users = emplyees;
          emit(FetchEmployeesSuccess(users: users));
        }
      },
    );
  }

  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final trimmed = query.trim().toLowerCase();
      if (trimmed.isEmpty) {
        emit(FetchEmployeesSuccess(users: users));
      } else {
        final filtered =
            users.where((u) {
              final queryLower = query.toLowerCase();
              return u.name.toLowerCase().contains(queryLower) ||
                  u.email.toLowerCase().contains(queryLower) ||
                  u.phone.toLowerCase().contains(queryLower);
            }).toList();
        emit(FetchEmployeesSuccess(users: filtered));
      }
    });
  }
}
