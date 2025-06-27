import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:palace_hr/core/helpers/is_english_locale_funcation.dart';
import 'package:palace_hr/core/utils/app_colors.dart';

Future<DateTime?> customTimePickerWithAmPm(BuildContext context) async {
  DateTime? dateTime;
  await picker.DatePicker.showPicker(
    context,
    showTitleActions: true,
    pickerModel: CustomTimePickerModel(
      currentTime: DateTime.now(),
      locale: isEnglishLocale() ? picker.LocaleType.en : picker.LocaleType.ar,
    ),
    theme: picker.DatePickerTheme(
      backgroundColor: Colors.white,
      itemStyle: const TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      doneStyle: TextStyle(color: AppColors.mainBlue, fontSize: 16),
    ),

    onConfirm: (date) {
      dateTime = date;
    },
  );
  return dateTime;
}

class CustomTimePickerModel extends picker.CommonPickerModel {
  CustomTimePickerModel({DateTime? currentTime, super.locale}) {
    this.currentTime = currentTime ?? DateTime.now();
    setLeftIndex(this.currentTime.hour % 12);
    setMiddleIndex(this.currentTime.minute);
    setRightIndex(this.currentTime.hour >= 12 ? 1 : 0); // 0 -> AM, 1 -> PM
  }

  String digits(int value, int length) => '$value'.padLeft(length, '0');

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index < 12) {
      return digits(index == 0 ? 12 : index, 2); // الساعة بصيغة 12
    }
    return null;
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2); // الدقائق
    }
    return null;
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index == 0) return isEnglishLocale() ? 'AM' : 'صباحًا';
    if (index == 1) return isEnglishLocale() ? 'PM' : 'مساءً';
    return null;
  }

  @override
  String leftDivider() => ":";

  @override
  String rightDivider() => " ";

  @override
  List<int> layoutProportions() => [2, 2, 1];

  @override
  DateTime finalTime() {
    int hour = currentLeftIndex();
    int minute = currentMiddleIndex();
    int amPm = currentRightIndex();

    hour = hour == 0 ? 12 : hour;
    if (amPm == 0 && hour == 12) {
      hour = 0;
    } else if (amPm == 1 && hour != 12) {
      hour += 12;
    }

    return DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      hour,
      minute,
    );
  }
}
