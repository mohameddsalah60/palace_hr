import 'package:palace_hr/features/home/domin/entites/schedules_entity.dart';

class SchedulesModel extends SchedulesEntity {
  SchedulesModel({required super.month, required super.days});

  factory SchedulesModel.fromJson(Map<String, dynamic> json) {
    return SchedulesModel(
      month: json['month'],
      days:
          (json['days'] as List).map((day) => DayModel.fromJson(day)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'days': days.map((day) => (day as DayModel).toJson()).toList(),
    };
  }
}

class DayModel extends DayEntity {
  DayModel({required super.day, required super.times, super.isOffDay = false});

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      day: json['day'] as int,
      times: Map<String, String>.from(json['times']),
      isOffDay: json['isOffDay'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'day': day, 'times': times, 'isOffDay': isOffDay};
  }
}
