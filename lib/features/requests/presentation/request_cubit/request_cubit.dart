import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:palace_hr/core/helpers/get_user.dart';
import 'package:palace_hr/core/widgets/custom_time_date_picker.dart';
import 'package:palace_hr/features/requests/domin/entites/request_user_input_entity.dart';
import 'package:palace_hr/features/requests/domin/repo/request_repo.dart';

import '../../../../core/helpers/is_english_locale_funcation.dart';
import '../../../../core/widgets/custom_month_date_picker.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit(this.requestRepo) : super(RequestInitial());
  TextEditingController requestDayDateController = TextEditingController();
  TextEditingController requestFromDateController = TextEditingController();
  TextEditingController requestToDateController = TextEditingController();
  TextEditingController requestNotesController = TextEditingController();
  TextEditingController requestAttachmentController = TextEditingController();
  String requestTypeController = '';
  int premission = 0;
  int leave = 0;
  final RequestRepo requestRepo;

  Future<void> chooseDayDate(BuildContext context) async {
    DateTime? selectedDate = await customMonthYearPicker(context);
    if (selectedDate != null) {
      requestDayDateController.text = '${selectedDate.toLocal()}'.split(' ')[0];
    }
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

  void setRequestType(String type) {
    requestTypeController = type;
    emit(RequestTypePermissionState());
  }

  void verifyRequestParameters() {
    if (requestTypeController.isEmpty) {
      emit(
        RequestErrorState(
          isEnglishLocale()
              ? 'Please select a request type.'
              : 'يرجى اختيار نوع الطلب.',
        ),
      );
      return;
    }
    if (requestDayDateController.text.isEmpty) {
      emit(
        RequestErrorState(
          isEnglishLocale()
              ? 'Please select a day date.'
              : 'يرجى اختيار تاريخ اليوم.',
        ),
      );
      return;
    }

    if (requestTypeController == 'Permissions') {
      if (requestFromDateController.text.isEmpty) {
        emit(
          RequestErrorState(
            isEnglishLocale()
                ? 'Please select a from date.'
                : 'يرجى اختيار وقت البدء.',
          ),
        );
        return;
      } else if (requestToDateController.text.isEmpty) {
        emit(
          RequestErrorState(
            isEnglishLocale()
                ? 'Please select a to date.'
                : 'يرجى اختيار وقت الانتهاء.',
          ),
        );
        return;
      }
    }

    if (premission == 0) {
      emit(
        RequestErrorState(
          isEnglishLocale()
              ? 'You have no permissions left.'
              : 'لا يوجد لديك أذونات متاحة.',
        ),
      );
      return;
    }

    if (leave == 0) {
      emit(
        RequestErrorState(
          isEnglishLocale()
              ? 'You have no Annoul Leave left.'
              : 'لا يوجد لديك إجازات سنوية متبقية.',
        ),
      );
      return;
    }

    if (requestTypeController != 'Permissions') {
      if (!isLeaveDateValid(DateTime.parse(requestDayDateController.text))) {
        emit(
          RequestErrorState(
            isEnglishLocale()
                ? 'Leave date must be at least 2 days from today.'
                : 'يجب أن يكون تاريخ الإجازة بعد يومين على الأقل من اليوم.',
          ),
        );
        return;
      }
    }
    if (requestTypeController == 'Permissions') {
      if (isPermissionDateInvalid(
        requestFromDateController.text,
        requestToDateController.text,
      )) {
        emit(RequestErrorState('وقت البداية يجب أن يكون قبل وقت النهاية.'));
        return;
      }
      if (!isPermissionDurationValid(
        requestFromDateController.text,
        requestToDateController.text,
      )) {
        emit(
          RequestErrorState(
            isEnglishLocale()
                ? 'permission duration must be exactly one hour.'
                : 'مدة الإذن يجب أن تكون ساعة واحدة فقط.',
          ),
        );
        return;
      }
    }
    sendRequest();
  }

  bool isPermissionDateInvalid(String from, String to) {
    var fromDate = parseTimeStringToDateTime(from);
    var toDate = parseTimeStringToDateTime(to);

    return fromDate.isAfter(toDate);
  }

  bool isPermissionDurationValid(String from, String to) {
    var fromDate = parseTimeStringToDateTime(from);
    var toDate = parseTimeStringToDateTime(to);

    final Duration difference = toDate.difference(fromDate);
    return difference.inMinutes == 60;
  }

  bool isLeaveDateValid(DateTime selectedDate) {
    final DateTime now = DateTime.now();
    final DateTime minAllowedDate = now.add(Duration(days: 2));

    return selectedDate.isAfter(minAllowedDate) ||
        selectedDate.isAtSameMomentAs(minAllowedDate);
  }

  Future<void> sendRequest() async {
    emit(RequestLoadingState());
    RequestUserInputEntity requestUserInputEntity = RequestUserInputEntity(
      requestCreatedBy: getUser().name,
      requestUserEmail: getUser().email,
      requestUserImage: getUser().faceIdUrl ?? '',
      requestCreatedAt: DateTime.now(),
      requestType: requestTypeController,
      requestDateDay: DateTime.parse(requestDayDateController.text),
      requestFromDate:
          requestFromDateController.text.isNotEmpty
              ? parseTimeStringToDateTime(requestFromDateController.text)
              : null,
      requestToDate:
          requestToDateController.text.isNotEmpty
              ? parseTimeStringToDateTime(requestToDateController.text)
              : null,
      requestNotes: requestNotesController.text,
    );
    log(requestUserInputEntity.requestFromDate.toString());
    var result = await requestRepo.createRequest(
      requestUserInputEntity: requestUserInputEntity,
    );
    result.fold(
      (error) {
        emit(RequestErrorState(error.errMessage));
      },
      (success) {
        requestDayDateController.clear();
        requestFromDateController.clear();
        requestToDateController.clear();
        requestNotesController.clear();
        requestAttachmentController.clear();
        requestTypeController = '';
        setRequestType('');
        emit(RequestSuccessState());
      },
    );
  }

  onClose() {
    requestDayDateController.dispose();
    requestFromDateController.dispose();
    requestToDateController.dispose();
    requestNotesController.dispose();
    requestAttachmentController.dispose();
    super.close();
  }

  DateTime parseTimeStringToDateTime(String date) {
    var timeDate = DateFormat('hh:mm a').parse(date);
    timeDate = DateTime(
      DateTime.parse(requestDayDateController.text).year,
      DateTime.parse(requestDayDateController.text).month,
      DateTime.parse(requestDayDateController.text).day,
      timeDate.hour,
      timeDate.minute,
    );
    return timeDate;
  }

  getDataUser() async {
    var result = await requestRepo.getDataUser();
    result.fold(
      (error) {
        emit(RequestErrorState(error.errMessage));
      },
      (success) {
        premission = getUser().countPermission;
        leave = getUser().countAnnualDays;
        log('User data fetched successfully');
      },
    );
  }
}
