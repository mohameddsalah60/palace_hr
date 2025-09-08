import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../penalties/domin/entites/penalty_entity.dart';
import '../../../domin/repos/dashboard_repo.dart';

part 'fetch_employee_penalties_state.dart';

class FetchEmployeePenaltiesCubit extends Cubit<FetchEmployeePenaltiesState> {
  final DashboardRepo dashboardRepo;
  FetchEmployeePenaltiesCubit(this.dashboardRepo)
    : super(FetchEmployeePenaltiesInitial());

  Future<void> fetchPenalties({required String email}) async {
    emit(FetchPenaltiesLoading());
    final result = await dashboardRepo.fetchUserPenalty(email: email);
    result.fold(
      (failure) => emit(FetchPenaltiesFailure(failure.errMessage)),
      (penalties) => emit(FetchPenaltiesSuccess(penalties)),
    );
  }
}
