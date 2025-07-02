import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/requests/domin/repo/request_repo.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../domin/entites/request_user_input_entity.dart';

part 'fetch_requests_state.dart';

class FetchRequestsCubit extends Cubit<FetchRequestsState> {
  FetchRequestsCubit(this.requestRepo) : super(FetchRequestsInitial());
  final RequestRepo requestRepo;
  List<RequestUserInputEntity> requests = [];
  int currunt = 0;

  final RefreshController refreshController = RefreshController();
  void onRefresh() async {
    fetchUserReqeusts();
    refreshController.refreshCompleted();
  }

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  void onLoading() async {
    fetchUserReqeusts();
    refreshController.loadComplete();
  }

  fetchUserReqeusts({DateTime? sort}) async {
    emit(FetchRequestsLoading());
    final result = await requestRepo.fetchUserRequest();
    result.fold(
      (failure) {
        emit(FetchRequestsFailure(message: failure.errMessage));
      },
      (list) {
        if (list.isEmpty) {
          emit(FetchRequestsEmpty(message: ''));
        }
        requests = list;
        fetchRequestsBySort();
      },
    );
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

    emit(FetchRequestsSuccess(requests: filteredList));
  }

  void cancelRequest(RequestUserInputEntity request) {
    requestRepo.cancelRequest(request: request).then((result) {
      result.fold(
        (failure) => emit(FetchRequestsFailure(message: failure.errMessage)),
        (_) {
          int index = requests.indexWhere(
            (element) =>
                element.requestDateDay!.year == request.requestDateDay!.year &&
                element.requestDateDay!.month ==
                    request.requestDateDay!.month &&
                element.requestDateDay!.day == request.requestDateDay!.day,
          );
          if (index != -1) {
            requests.removeAt(index);
          }
          fetchRequestsBySort();
        },
      );
    });
  }
}
