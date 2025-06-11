import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:palace_hr/core/errors/api_error_model.dart';
import 'package:palace_hr/core/helpers/get_user.dart';
import 'package:palace_hr/features/penalties/data/models/penalty_model.dart';
import 'package:palace_hr/features/penalties/domin/entites/penalty_entity.dart';
import 'package:palace_hr/features/penalties/domin/repo/penalties_repo.dart';

import '../../../../core/errors/api_error_handler.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/networking/constants_database_path.dart';
import '../../../../core/networking/database_service.dart';
import '../../../../core/networking/storage_service.dart';

class PenaltiesRepoImpl implements PenaltiesRepo {
  final StorageService storageService;
  final DatabaseService databaseService;

  PenaltiesRepoImpl({
    required this.storageService,
    required this.databaseService,
  });
  @override
  Future<Either<ApiErrorModel, void>> addUserPenalty({
    required PenaltyEntity penalty,
  }) async {
    try {
      Map<String, dynamic> penaltyModel =
          PenaltyModel.fromEntity(penalty).toMap();

      await databaseService.addData(
        data: penaltyModel,
        path: ConstantsDatabasePath.getUserData,
        docId: getUser().email,
        subPath: ConstantsDatabasePath.getUserMyPenalties,
        subPathDocId:
            "${penalty.date.year}-${penalty.date.month}-${penalty.date.day}",
      );

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

  @override
  Future<Either<ApiErrorModel, List<PenaltyEntity>>> fetchUserPenalty({
    DateTime? sort,
  }) async {
    try {
      List<PenaltyEntity> penalties = [];
      var response = await databaseService.getData(
        path: ConstantsDatabasePath.getUserData,
        uId: getUser().email,
        subPath: ConstantsDatabasePath.getUserMyPenalties,
      );
      for (var i in response) {
        PenaltyEntity penaltyEntity = PenaltyModel.fromJson(i);
        penalties.add(penaltyEntity);
      }
      log(penalties.toString());
      return right(penalties);
    } catch (e) {
      log(e.toString());

      return left(
        ServerFailure(errMessage: ApiErrorHandler.handleError(e).errMessage),
      );
    }
  }
}
