import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/home/domin/repos/home_repo.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../domin/entites/schedules_entity.dart';

part 'user_schedule_state.dart';

class UserScheduleCubit extends Cubit<UserScheduleState> {
  UserScheduleCubit(this.homeRepo) : super(UserScheduleInitial());
  final HomeRepo homeRepo;
  SchedulesEntity? schedulesList;
  DayEntity? dayEntity;
  final RefreshController refreshController = RefreshController();
  void onRefresh() async {
    loadUserSchedules(); // أو أي method تعيد التحميل
    refreshController.refreshCompleted(); // أو refreshFailed حسب النتيجة
  }

  void onLoading() async {
    loadUserSchedules();
    refreshController.loadComplete(); // أو loadFailed حسب النتيجة
  }

  void updateSelectedDay(DateTime date) {
    if (schedulesList == null) return;
    dayEntity = schedulesList!.getScheduleToday(date: date);
    emit(UserScheduleSuccess(schedules: schedulesList!));
  }

  Future<void> loadUserSchedules({DateTime? date}) async {
    emit(UserScheduleLoading());
    final now = DateTime.now();

    final result = await homeRepo.loadUserSchedules(date: date ?? now);
    result.fold((l) => emit(UserScheduleFailure(message: l.errMessage)), (
      schedules,
    ) {
      dayEntity = schedules.getScheduleToday(date: date);
      schedulesList = schedules;
      emit(UserScheduleSuccess(schedules: schedules));
    });
  }
}
