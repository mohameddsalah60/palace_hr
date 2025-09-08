import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/dashboard/domin/repos/dashboard_repo.dart';
import 'package:palace_hr/features/requests/domin/entites/request_user_input_entity.dart';

part 'fetch_employees_requests_state.dart';

class FetchEmployeesRequestsCubit extends Cubit<FetchEmployeesRequestsState> {
  FetchEmployeesRequestsCubit(this.dashboardRepo)
    : super(FetchEmployeesRequestsInitial());
  final DashboardRepo dashboardRepo;
  Timer? _debounce;
  List<RequestUserInputEntity> requests = [];
  void fetchEmployeesRequests({String? email}) async {
    emit(FetchEmployeesRequestsLoading());
    final result = await dashboardRepo.fetchRequests(email: email);
    result.fold(
      (failure) {
        emit(FetchEmployeesRequestsFailure(message: failure.errMessage));
      },
      (reqs) {
        requests = reqs;
        emit(
          FetchEmployeesRequestSuccess(
            requests:
                reqs.where((req) => req.requestStatus == 'pending').toList(),
          ),
        );
      },
    );
  }

  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final trimmed = query.trim().toLowerCase();
      if (trimmed.isEmpty) {
        emit(FetchEmployeesRequestSuccess(requests: requests));
      } else {
        final filtered =
            requests.where((u) {
              final queryLower = query.toLowerCase();
              return u.requestCreatedBy.toLowerCase().contains(queryLower);
            }).toList();
        emit(FetchEmployeesRequestSuccess(requests: filtered));
      }
    });
  }

  void fetchRequestsBySort({String? status = 'pending'}) {
    if (status == 'قيد الانتظار') {
      status = 'pending';
    } else if (status == 'مقبول') {
      status = 'approved';
    } else if (status == 'مرفوض') {
      status = 'rejected';
    }
    final filteredList =
        requests.where((element) => element.requestStatus == status).toList();

    emit(FetchEmployeesRequestSuccess(requests: filteredList));
  }

  void approveRequest({required RequestUserInputEntity request}) async {
    emit(FetchEmployeesRequestsLoading());
    final result = await dashboardRepo.approveRequest(request: request);
    result.fold(
      (failure) {
        emit(FetchEmployeesRequestsFailure(message: failure.errMessage));
      },
      (reqs) {
        emit(FetchEmployeesRequestSuccess(requests: requests));
      },
    );
  }

  void rejectedRequest({required RequestUserInputEntity request}) async {
    emit(FetchEmployeesRequestsLoading());
    final result = await dashboardRepo.rejectRequest(request: request);
    result.fold(
      (failure) {
        emit(FetchEmployeesRequestsFailure(message: failure.errMessage));
      },
      (reqs) {
        emit(FetchEmployeesRequestSuccess(requests: requests));
      },
    );
  }
}
