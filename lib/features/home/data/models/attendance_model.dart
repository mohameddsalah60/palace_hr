import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:palace_hr/features/home/domin/entites/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity {
  AttendanceModel({
    required super.dateTime,
    required super.checkIn,
    super.checkOut,
    required super.isLate,
    required super.location,
  });
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      dateTime: (json['dateTime'] as Timestamp).toDate(),
      checkIn: json['checkIn'] ?? '',
      checkOut: json['checkOut'] ?? '',
      isLate: (json['isLate'] as bool),
      location: Map<String, double>.from(json['location']),
    );
  }
  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      dateTime: entity.dateTime,
      checkIn: entity.checkIn,
      checkOut: entity.checkOut ?? '',
      isLate: entity.isLate,
      location: entity.location,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'isLate': isLate,
      'location': location,
    };
  }
}
