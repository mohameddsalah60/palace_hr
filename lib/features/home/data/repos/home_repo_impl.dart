import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'package:palace_hr/core/errors/api_error_model.dart';
import 'package:palace_hr/core/errors/exceptions.dart';
import 'package:palace_hr/core/helpers/get_user.dart';
import 'package:palace_hr/core/helpers/is_english_locale_funcation.dart';
import 'package:palace_hr/core/networking/constants_database_path.dart';
import 'package:palace_hr/core/networking/database_service.dart';
import 'package:palace_hr/core/networking/storage_service.dart';
import 'package:palace_hr/core/services/shared_preferences_service.dart';
import 'package:palace_hr/features/home/domin/entites/schedules_entity.dart';

import '../../../../core/errors/api_error_handler.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domin/repos/home_repo.dart';
import '../models/schedules_model.dart';

class HomeRepoImpl implements HomeRepo {
  final StorageService storageService;
  final DatabaseService databaseService;
  HomeRepoImpl({required this.storageService, required this.databaseService});
  @override
  Future<Either<ApiErrorModel, String>> uploadImage(
    File image,
    String path,
  ) async {
    try {
      final options = FaceDetectorOptions();
      final faceDetector = FaceDetector(options: options);
      final inputImage = InputImage.fromFilePath(path);
      final List<Face> faces = await faceDetector.processImage(inputImage);
      if (faces.isEmpty) {
        return left(
          ServerFailure(
            errMessage:
                isEnglishLocale() ? 'No face found' : 'لم يتم العثور على وجه',
          ),
        );
      } else if (faces.length > 1) {
        return left(
          ServerFailure(
            errMessage:
                isEnglishLocale()
                    ? 'Only one face is allowed'
                    : 'يجب أن يكون وجه واحد فقط',
          ),
        );
      }
      var reslut = await storageService.uploudFile(file: image, path: path);

      return right(reslut);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    } catch (e) {
      log(e.toString());

      return left(
        ServerFailure(errMessage: ApiErrorHandler.handleError(e).errMessage),
      );
    }
  }

  @override
  Future<Either<ApiErrorModel, void>> setFaceUserImage({
    required String path,
  }) async {
    try {
      await databaseService.updateData(
        path: ConstantsDatabasePath.getUserData,
        uId: getUser().email,
        value: {'faceIdUrl': path},
      );
      await updateUserData(path);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    } catch (e) {
      log(e.toString());
      return left(
        ServerFailure(errMessage: ApiErrorHandler.handleError(e).errMessage),
      );
    }
  }

  Future<void> updateUserData(String path) async {
    var user = getUser();
    user.faceIdUrl = path;
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());

    await SharedPreferencesService.setData(
      key: ConstantsDatabasePath.userDataLocalStorage,
      value: jsonData,
    );
  }

  @override
  Future<Either<ApiErrorModel, SchedulesEntity>> loadUserSchedules({
    required DateTime date,
  }) async {
    try {
      final formattedMonth =
          "${date.year}-${date.month.toString().padLeft(2, '0')}";
      final result = await databaseService.getData(
        path: ConstantsDatabasePath.getUserData,
        uId: getUser().email,
        subPath: ConstantsDatabasePath.getUserSchedule,
        subPathId: formattedMonth,
      );
      SchedulesEntity schedules = SchedulesModel.fromJson(result);

      return right(schedules);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    } catch (e) {
      log(e.toString());
      return left(
        ServerFailure(errMessage: ApiErrorHandler.handleError(e).errMessage),
      );
    }
  }
}
