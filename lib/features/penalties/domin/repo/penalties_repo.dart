import 'package:dartz/dartz.dart';
import 'package:palace_hr/core/errors/api_error_model.dart';
import 'package:palace_hr/features/penalties/domin/entites/penalty_entity.dart';

abstract class PenaltiesRepo {
  Future<Either<ApiErrorModel, void>> addUserPenalty({
    required PenaltyEntity penalty,
  });
  Future<Either<ApiErrorModel, List<PenaltyEntity>>> fetchUserPenalty({
    DateTime? sort,
  });
}
