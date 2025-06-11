import 'package:palace_hr/features/penalties/domin/entites/penalty_entity.dart';

class PenaltyModel extends PenaltyEntity {
  PenaltyModel({
    required super.title,
    required super.description,
    required super.value,
    required super.date,
  });

  factory PenaltyModel.fromJson(Map<String, dynamic> data) {
    return PenaltyModel(
      title: data['title'],
      description: data['description'],
      value: data['value'],
      date: data['date'].toDate(),
    );
  }

  factory PenaltyModel.fromEntity(PenaltyEntity penalty) {
    return PenaltyModel(
      title: penalty.title,
      description: penalty.description,
      value: penalty.value,
      date: penalty.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'value': value,
    };
  }
}
