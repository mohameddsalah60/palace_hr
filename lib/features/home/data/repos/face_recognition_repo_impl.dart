import 'dart:developer';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_face_api/flutter_face_api.dart';
import 'package:http/http.dart' as http;
import 'package:palace_hr/core/errors/api_error_model.dart';

import '../../../../core/errors/errors_messages.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/helpers/get_user.dart';
import '../../../../core/helpers/is_english_locale_funcation.dart';
import '../../domin/repos/face_recognition_repo.dart';

class FaceRecognitionRepoImpl implements FaceRecognitionRepo {
  @override
  Future<Either<ApiErrorModel, bool>> validateFaceRecognition({
    required Uint8List photo,
  }) async {
    try {
      var response_ = await http.get(Uri.parse(getUser().faceIdUrl!));

      if (response_.statusCode == 200) {
        Uint8List imageBytes = response_.bodyBytes;

        MatchFacesImage mfImage1 = MatchFacesImage(
          imageBytes,
          ImageType.PRINTED,
        );
        MatchFacesImage mfImage2 = MatchFacesImage(photo, ImageType.PRINTED);

        var request = MatchFacesRequest([mfImage1, mfImage2]);

        var response = await FaceSDK.instance.matchFaces(request);

        var split = await FaceSDK.instance.splitComparedFaces(
          response.results,
          0.75,
        );

        var match = split.matchedFaces;
        if (match.isNotEmpty) {
          var faceSimilarity = (match[0].similarity * 100).toStringAsFixed(2);
          log("Face similarity: $faceSimilarity%");
          return right(double.parse(faceSimilarity) >= 95.0);
        } else {
          return left(
            ServerFailure(
              errMessage:
                  isEnglishLocale() ? "Face not matched" : "الوجه غير متطابق",
            ),
          );
        }
      } else {
        throw CustomException(message: ErrorMessages.genericErrorMessage);
      }
    } catch (e) {
      log(e.toString());
      if (e is CustomException) {
        return left(ServerFailure(errMessage: e.message));
      }
      if (e is ApiErrorModel) {
        return left(e);
      }
      return left(
        ServerFailure(
          errMessage:
              isEnglishLocale()
                  ? "An error occurred while processing the image"
                  : "حدث خطأ أثناء معالجة الصورة",
        ),
      );
    }
  }
}
