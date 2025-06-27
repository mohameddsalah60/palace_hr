import '../../domin/entites/request_user_input_entity.dart';

class RequestUserInputModel extends RequestUserInputEntity {
  RequestUserInputModel({
    required super.requestType,
    super.requestStatus,
    required super.requestDateDay,
    required super.requestFromDate,
    required super.requestToDate,
    required super.requestNotes,
    super.requestCreatedAt,
  });

  factory RequestUserInputModel.fromMap(Map<String, dynamic> data) {
    return RequestUserInputModel(
      requestCreatedAt:
          data['requestCreatedAt'] != null
              ? DateTime.parse(data['requestCreatedAt'])
              : null,
      requestType: data['requestType'],
      requestStatus: data['requestStatus'] ?? 'pending',
      requestDateDay:
          data['requestDateDay'] != null
              ? DateTime.parse(data['requestDateDay'])
              : null,
      requestFromDate:
          data['requestFromDate'] != null
              ? DateTime.parse(data['requestFromDate'])
              : null,
      requestToDate:
          data['requestToDate'] != null
              ? DateTime.parse(data['requestToDate'])
              : null,
      requestNotes: data['requestNotes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requestType': requestType,
      'requestStatus': requestStatus,
      'requestDateDay': requestDateDay?.toIso8601String(),
      'requestCreatedAt': requestCreatedAt?.toIso8601String(),
      'requestFromDate': requestFromDate?.toIso8601String(),
      'requestToDate': requestToDate?.toIso8601String(),
      'requestNotes': requestNotes,
    };
  }

  factory RequestUserInputModel.fromJson(Map<String, dynamic> json) {
    return RequestUserInputModel.fromMap(json);
  }
  factory RequestUserInputModel.fromEntity(RequestUserInputEntity entity) {
    return RequestUserInputModel(
      requestType: entity.requestType,
      requestStatus: entity.requestStatus,
      requestDateDay: entity.requestDateDay,
      requestFromDate: entity.requestFromDate,
      requestToDate: entity.requestToDate,
      requestNotes: entity.requestNotes,
      requestCreatedAt: entity.requestCreatedAt,
    );
  }
  Map<String, dynamic> toJson() {
    return toMap();
  }
}
