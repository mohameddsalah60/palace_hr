import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/api_error_model.dart';

abstract class FaceRecognitionRepo {
  Future<Either<ApiErrorModel, bool>> validateFaceRecognition({
    required Uint8List photo,
  });
}
