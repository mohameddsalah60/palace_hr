import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palace_hr/features/home/domin/repos/face_user_repo.dart';

import '../../../../../core/helpers/get_user.dart';

part 'firset_selfie_state.dart';

class FirsetSelfieCubit extends Cubit<FirsetSelfieState> {
  FirsetSelfieCubit(this.userRepo) : super(FirsetSelfieInitial());

  final FaceUserRepo userRepo;
  bool isLoading = false;
  String urlImageUser = getUser().faceIdUrl ?? '';

  Future<XFile?> getPhoto() async {
    final ImagePicker picker = ImagePicker();

    if (kDebugMode) {
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

      return photo;
    } else {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      return photo;
    }
  }

  Future<void> uploudFile() async {
    var urlImage = await getPhoto();

    if (urlImage != null) {
      emit(FirsetSelfieLoading());
      isLoading = true;
      File file = File(urlImage.path);
      var result = await userRepo.uploadImage(file, urlImage.path);
      result.fold(
        (failure) {
          isLoading = false;
          emit(FirsetSelfieFailure(failure.errMessage));
          log(failure.errMessage);
        },
        (url) async {
          var updateImage = await userRepo.setFaceUserImage(path: url);
          updateImage.fold(
            (failure) {
              isLoading = false;

              emit(FirsetSelfieFailure(failure.errMessage));
            },
            (success) {
              isLoading = false;
              urlImageUser = getUser().faceIdUrl!;
              emit(FirsetSelfieSuccess());
            },
          );
        },
      );
    }
  }
}
