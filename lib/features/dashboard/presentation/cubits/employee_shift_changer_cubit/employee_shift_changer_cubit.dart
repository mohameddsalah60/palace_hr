import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:palace_hr/features/home/domin/entites/schedules_entity.dart';

import '../../../../../core/helpers/is_english_locale_funcation.dart';
import '../../../../../core/widgets/custom_time_date_picker.dart';
import '../../../domin/repos/dashboard_repo.dart';

part 'employee_shift_changer_state.dart';

class EmployeeShiftChangerCubit extends Cubit<EmployeeShiftChangerState> {
  EmployeeShiftChangerCubit(this.emailUser, this.dashboardRepo)
    : super(EmployeeShiftChangerInitial());
  final String emailUser;
  final DashboardRepo dashboardRepo;

  late DateTime focusedDay;
  DateTime? selectedDay;
  bool applyToMonth = false;
  bool isDayOff = false;

  TextEditingController shiftStartDateController = TextEditingController();
  TextEditingController shiftEndDateController = TextEditingController();

  void initCubit() {
    focusedDay = DateTime.now();
    selectedDay = focusedDay;
  }

  void setSelectedDay(DateTime? date) {
    selectedDay = date;
    focusedDay = date ?? DateTime.now();
    emit(EmployeeShiftChangerUpdateUI());
  }

  void toggleApplyToMonth() {
    applyToMonth = !applyToMonth;
    emit(EmployeeShiftChangerUpdateUI());
  }

  void toggleDayOff() {
    isDayOff = !isDayOff;
    emit(EmployeeShiftChangerUpdateUI());
  }

  void setScheduleUserInput() async {
    if (!isDayOff &&
        (shiftStartDateController.text.isEmpty ||
            shiftEndDateController.text.isEmpty)) {
      emit(
        EmployeeShiftChangerError(
          message:
              isEnglishLocale()
                  ? 'Please fill in all fields.'
                  : 'يرجى ملء جميع الحقول.',
        ),
      );
      return;
    }

    if (applyToMonth && isDayOff) {
      emit(
        EmployeeShiftChangerError(
          message:
              isEnglishLocale()
                  ? 'Cannot apply to month when the day is marked as off.'
                  : 'لا يمكن تطبيق على الشهر عندما يكون اليوم محددًا كإجازة.',
        ),
      );
      return;
    }
    if (!validateShiftDuration(
      startTimeText: shiftStartDateController.text,
      endTimeText: shiftEndDateController.text,
      isDayOff: isDayOff,
    )) {
      return;
    }
    final DateTime selectedDate = selectedDay!;
    final DateTime startTime =
        shiftStartDateController.text.isNotEmpty
            ? _mergeDateAndTime(
              selectedDate,
              DateFormat('hh:mm a').parse(shiftStartDateController.text),
            )
            : selectedDate;

    final DateTime endTime =
        shiftEndDateController.text.isNotEmpty
            ? _mergeDateAndTime(
              selectedDate,
              DateFormat('hh:mm a').parse(shiftEndDateController.text),
            )
            : selectedDate;

    final dayEntity = DayEntity(
      day: selectedDate.day,
      times: {"start": startTime, "end": endTime},
      isOffDay: isDayOff,
    );

    final result = await dashboardRepo.setScheduleUser(
      email: emailUser,
      day: dayEntity,
      applyToMonth: applyToMonth,
    );

    result.fold(
      (failure) {
        log(failure.errMessage);
        emit(EmployeeShiftChangerError(message: failure.errMessage));
      },
      (success) {
        log('Schedule updated successfully for $emailUser');
        emit(EmployeeShiftChangerSuccess());
      },
    );
  }

  Future<void> chooseTimeDate(
    BuildContext context,
    TextEditingController control,
  ) async {
    DateTime? selectedDate = await customTimePickerWithAmPm(context);
    if (selectedDate != null) {
      String formatted = DateFormat(
        'hh:mm a',
        isEnglishLocale() ? 'en' : 'ar',
      ).format(selectedDate);
      control.text = formatted.padLeft(2, '0');
    }
  }

  DateTime _mergeDateAndTime(DateTime date, DateTime time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  bool validateShiftDuration({
    required String startTimeText,
    required String endTimeText,
    required bool isDayOff,
  }) {
    if (isDayOff) return true; // اليوم أجازة، الشرط مش مطلوب

    if (startTimeText.isEmpty || endTimeText.isEmpty) {
      emit(
        EmployeeShiftChangerError(
          message:
              isEnglishLocale()
                  ? 'Please fill in all fields.'
                  : 'يرجى ملء جميع الحقول.',
        ),
      );
      return false;
    }

    final startTime = DateFormat('hh:mm a').parse(startTimeText);
    var endTime = DateFormat('hh:mm a').parse(endTimeText);

    // لو النهاية قبل البداية نعتبرها لليوم اللي بعده
    if (endTime.isBefore(startTime)) {
      endTime = endTime.add(const Duration(days: 1));
    }

    final shiftDuration = endTime.difference(startTime).inHours;

    if (shiftDuration < 6) {
      emit(
        EmployeeShiftChangerError(
          message:
              isEnglishLocale()
                  ? 'Shift must be at least 6 hours.'
                  : 'يجب ألا يقل الشيفت عن 6 ساعات.',
        ),
      );
      return false;
    }

    return true;
  }
}
