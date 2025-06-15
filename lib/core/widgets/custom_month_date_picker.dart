import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:palace_hr/core/helpers/is_english_locale_funcation.dart';

Future<DateTime?> customMonthYearPicker(BuildContext context) async {
  DateTime? selectedDate;
  await DatePicker.showDatePicker(
    context,
    showTitleActions: true,
    minTime: DateTime(2020, 1, 1),
    maxTime: DateTime(DateTime.now().year + 5, DateTime.now().month),
    onConfirm: (date) {
      selectedDate = date;
    },
    currentTime: DateTime.now(),
    locale: isEnglishLocale() ? LocaleType.en : LocaleType.ar,
  );
  return selectedDate;
}
