import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/core/helpers/get_user.dart';
import 'package:palace_hr/features/home/domin/repos/home_repo.dart';
import 'package:palace_hr/features/home/domin/repos/schedules_repo.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'dart:developer' as log;

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palace_hr/features/home/domin/entites/attendance_entity.dart';

import '../../../domin/entites/schedules_entity.dart';
import '../../../domin/repos/face_recognition_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo, this.faceRecognitionRepo, this.schedulesRepo)
    : super(HomeStateInitial());
  final HomeRepo homeRepo;
  final SchedulesRepo schedulesRepo;
  final FaceRecognitionRepo faceRecognitionRepo;
  String checkInTime = '--:--:--';
  String checkOutTime = '--:--:--';
  SchedulesEntity? schedulesList;
  DayEntity? dayEntity;
  String? face = getUser().faceIdUrl;
  DateTime dateT = DateTime.now();

  final RefreshController refreshController = RefreshController();
  void onRefresh() async {
    loadUserSchedules();
    refreshController.refreshCompleted();
  }

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  void onLoading() async {
    loadUserSchedules();
    refreshController.loadComplete();
  }

  void updateSelectedDay(DateTime date) async {
    if (schedulesList == null) return;
    dayEntity = schedulesList!.getScheduleToday(date: date);
    final attendance = await homeRepo.getAttendanceIfExists(path: date);
    dateT = date;
    checkInTime = attendance?.checkIn ?? '--:--:--';
    checkOutTime = attendance?.checkOut ?? '--:--:--';
    emit(HomeStateSuccess(schedules: schedulesList!));
  }

  Future<void> loadUserSchedules({DateTime? date}) async {
    emit(HomeStateLoading());
    final now = DateTime.now();

    final result = await schedulesRepo.loadUserSchedules(date: date ?? now);
    result.fold((l) => emit(HomeStateFailure(message: l.errMessage)), (
      schedules,
    ) async {
      schedulesList = schedules;
      dayEntity = schedulesList!.getScheduleToday(date: date);
      final attendance = await homeRepo.getAttendanceIfExists(path: now);
      checkInTime = attendance?.checkIn ?? '--:--:--';
      checkOutTime = attendance?.checkOut ?? '--:--:--';
      emit(HomeStateSuccess(schedules: schedules));
    });
  }

  Future<bool> isUserLate(DateTime scheduledTime) async {
    DateTime now = DateTime.now();

    final difference = now.difference(scheduledTime);

    log.log('Current time difference in minutes: ${difference.inMinutes}');

    if (difference.inMinutes < 15) {
      return false;
    } else {
      return true;
    }
  }

  onCheckIn({DateTime? dateScheduled}) async {
    DateTime now = DateTime.now();
    bool late = await isUserLate(dateScheduled!);
    AttendanceEntity attendanceEntity = AttendanceEntity(
      dateTime: DateTime(
        dateScheduled.year,
        dateScheduled.month,
        dateScheduled.day,
        dateScheduled.hour,
        dateScheduled.minute,
      ),
      checkIn: "${now.hour}:${now.minute}:${now.second}",
      checkOut: '',
      isLate: late,
      location: {"lat": 0.0, "long": 0.0},
    );

    XFile? photo = await getPhoto();
    if (photo == null) {
      return;
    }
    emit(HomeStateLoading());
    final validate = await faceRecognitionRepo.validateFaceRecognition(
      photo: await photo.readAsBytes(),
    );
    validate.fold((l) => emit(HomeStateFailure(message: l.errMessage)), (
      success,
    ) async {
      log.log("Face recognition validated successfully");
      final result = await homeRepo.onCheckIn(
        attendanceEntity: attendanceEntity,
        photo: await photo.readAsBytes(),
      );
      result.fold((l) => emit(HomeStateFailure(message: l.errMessage)), (
        attendance,
      ) {
        log.log("Attendance logged successfully");
        checkInTime = attendanceEntity.checkIn;
        emit(HomeStateAttendanceSuccess());
      });
    });
  }

  onCheckOut({DateTime? dateScheduled, String? checkOut}) async {
    XFile? photo = await getPhoto();
    if (photo == null) {
      return;
    }
    emit(HomeStateLoading());
    final validate = await faceRecognitionRepo.validateFaceRecognition(
      photo: await photo.readAsBytes(),
    );
    validate.fold((l) => emit(HomeStateFailure(message: l.errMessage)), (
      success,
    ) async {
      log.log("Face recognition validated successfully");
      final result = await homeRepo.onCheckOut(
        dateTime: dateScheduled!,
        photo: await photo.readAsBytes(),
      );
      result.fold((l) => emit(HomeStateFailure(message: l.errMessage)), (_) {
        log.log("Attendance logged successfully");
        checkOutTime =
            "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
        emit(HomeStateAttendanceSuccess());
      });
    });
  }

  Future<XFile?> getPhoto() async {
    final ImagePicker picker = ImagePicker();

    if (kDebugMode) {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      return photo;
    } else {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      return photo;
    }
  }

  emitHomeView() {
    emit(HomeStateSuccess(schedules: schedulesList!));
  }
}
