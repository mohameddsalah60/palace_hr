import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/api_error_model.dart';

abstract class FaceUserRepo {
  Future<Either<ApiErrorModel, String>> uploadImage(File image, String path);
  Future<Either<ApiErrorModel, void>> setFaceUserImage({required String path});
}
