import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:palace_hr/core/errors/api_error_model.dart';

abstract class HomeRepo {
  Future<Either<ApiErrorModel, String>> uploadImage(File image, String path);
  Future<Either<ApiErrorModel, void>> setFaceUserImage({required String path});
}
