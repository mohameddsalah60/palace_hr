import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/penalties/domin/entites/penalty_entity.dart';
import 'package:palace_hr/features/penalties/domin/repo/penalties_repo.dart';

part 'fetch_pentalties_state.dart';

class FetchPenaltiesCubit extends Cubit<FetchPentaltiesState> {
  FetchPenaltiesCubit(this.penaltiesRepo) : super(FetchPentaltiesInitial());
  final PenaltiesRepo penaltiesRepo;
  fetchPenalties({DateTime? sort}) async {
    emit(FetchPentaltiesLoading());
    final result = await penaltiesRepo.fetchUserPenalty(sort: sort);
    result.fold(
      (failure) {
        emit(FetchPentaltiesFailure(message: failure.errMessage));
      },
      (list) {
        emit(FetchPentaltiesSuccess(penalties: list));
      },
    );
  }
}
