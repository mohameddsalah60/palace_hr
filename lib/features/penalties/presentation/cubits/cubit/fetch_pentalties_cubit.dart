import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/penalties/domin/entites/penalty_entity.dart';
import 'package:palace_hr/features/penalties/domin/repo/penalties_repo.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

part 'fetch_pentalties_state.dart';

class FetchPenaltiesCubit extends Cubit<FetchPentaltiesState> {
  FetchPenaltiesCubit(this.penaltiesRepo) : super(FetchPentaltiesInitial());
  final PenaltiesRepo penaltiesRepo;
  List<PenaltyEntity> penalties = [];
  final RefreshController refreshController = RefreshController();

  void onRefresh() async {
    fetchPenalties();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    fetchPenalties();
    refreshController.loadComplete();
  }

  fetchPenalties({DateTime? sort}) async {
    emit(FetchPentaltiesLoading());
    final result = await penaltiesRepo.fetchUserPenalty(sort: sort);

    result.fold(
      (failure) {
        emit(FetchPentaltiesFailure(message: failure.errMessage));
      },
      (list) {
        penalties = list;
        emit(FetchPentaltiesSuccess());
      },
    );
  }
}
