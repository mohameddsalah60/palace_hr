import '../../data/models/schedules_model.dart';

class SchedulesEntity {
  final String month; // "2025-05"
  final List<DayEntity> days; // قائمة بالأيام كلها في الشهر

  DayEntity getScheduleToday({DateTime? date}) {
    final sDay = date?.day ?? DateTime.now().day;
    return days.firstWhere(
      (day) =>
          day.day == sDay &&
          day.times['start'] != null &&
          day.times['end'] != null,
      orElse:
          () => DayModel(
            day: sDay,
            times: {"start": "", "end": ""},
            isOffDay: true,
          ),
    );
  }

  SchedulesEntity({required this.month, required this.days});
}

class DayEntity {
  final int day; // 1, 2, 3 ... 31
  final Map<String, String> times; // {"start": "09:00", "end": "17:00"}
  final bool isOffDay;

  DayEntity({required this.day, required this.times, this.isOffDay = false});
}
