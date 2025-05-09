class ApiErrorModel {
  final String errMessage;

  ApiErrorModel({required this.errMessage});
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(errMessage: json['message'] ?? 'Unknown error');
  }
}

class ServerFailure extends ApiErrorModel {
  ServerFailure({required super.errMessage});
}
