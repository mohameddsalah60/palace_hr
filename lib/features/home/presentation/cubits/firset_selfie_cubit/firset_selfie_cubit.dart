import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:palace_hr/features/home/domin/repos/home_repo.dart';

part 'firset_selfie_state.dart';

class FirsetSelfieCubit extends Cubit<FirsetSelfieState> {
  FirsetSelfieCubit(this.homeRepo) : super(FirsetSelfieInitial());
  final HomeRepo homeRepo;
  bool isLoading = false;

  Future<XFile?> getPhoto() async {
    final ImagePicker picker = ImagePicker();

    if (kDebugMode && Platform.isIOS) {
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

      return photo;
    } else {
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
      return photo;
    }
  }

  Future<void> uploudFile() async {
    var urlImage = await getPhoto();

    if (urlImage != null) {
      emit(FirsetSelfieLoading());
      isLoading = true;
      File file = File(urlImage.path);
      var result = await homeRepo.uploadImage(file, urlImage.path);
      result.fold(
        (failure) {
          isLoading = false;
          emit(FirsetSelfieFailure(failure.errMessage));
          log(failure.errMessage);
        },
        (url) async {
          var updateImage = await homeRepo.setFaceUserImage(path: url);
          updateImage.fold(
            (failure) {
              isLoading = false;

              emit(FirsetSelfieFailure(failure.errMessage));
            },
            (success) {
              isLoading = false;

              emit(FirsetSelfieSuccess());
            },
          );
        },
      );
    }
  }
}
