import 'package:intl/intl.dart';

import '../../../../core/helpers/is_english_locale_funcation.dart';
import '../../data/models/schedules_model.dart';

class SchedulesEntity {
  final List<DayEntity> days;

  DayEntity getScheduleToday({DateTime? date}) {
    final selectedDay = date?.day ?? DateTime.now().day;
    return days.firstWhere(
      (day) =>
          day.day == selectedDay &&
          day.times['start'] != null &&
          day.times['end'] != null,

      orElse:
          () => DayModel(
            day: selectedDay,
            times: {"start": DateTime.now(), "end": DateTime.now()},
            isOffDay: true,
          ),
    );
  }

  SchedulesEntity({required this.days});
}

class DayEntity {
  final int day;
  final Map<String, DateTime> times;
  bool isOffDay;
  String formatTime(DateTime? time) {
    if (time == null) return '--:--';
    String formatted = DateFormat(
      'hh:mm a',
      isEnglishLocale() ? 'en' : 'ar',
    ).format(time);

    return formatted.toString().padLeft(2, '0');
  }

  DayEntity({required this.day, required this.times, this.isOffDay = false});

  String monthName(int month) {
    const monthsAr = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    const monthsEn = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return isEnglishLocale() ? monthsEn[month - 1] : monthsAr[month - 1];
  }

  String weekdayName(int day) {
    const daysAr = [
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
      'الاثنين',
    ];
    const daysEn = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    int index = day - 1;
    return isEnglishLocale() ? daysEn[index] : daysAr[index];
  }

  String pad(int n) => n.toString().padLeft(2, '0');
}
