import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:palace_hr/features/home/domin/entites/schedules_entity.dart';

class SchedulesModel extends SchedulesEntity {
  SchedulesModel({required super.days});

  factory SchedulesModel.fromJson(Map<String, dynamic> json) {
    return SchedulesModel(
      days:
          (json['days'] as List).map((day) => DayModel.fromJson(day)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'days': days.map((day) => (day as DayModel).toJson()).toList()};
  }
}

class DayModel extends DayEntity {
  DayModel({required super.day, required super.times, super.isOffDay = false});

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      day: json['day'] as int,
      times: (json['times'] as Map<String, dynamic>).map((key, value) {
        if (value is Timestamp) {
          return MapEntry(key, value.toDate());
        } else if (value is String) {
          return MapEntry(key, DateTime.parse(value));
        } else {
          throw Exception('Invalid date format in times map');
        }
      }),
      isOffDay: json['isOffDay'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'day': day, 'times': times, 'isOffDay': isOffDay};
  }
}
