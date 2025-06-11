import 'package:dartz/dartz.dart';

import '../../../../core/errors/api_error_model.dart';
import '../entites/schedules_entity.dart';

abstract class SchedulesRepo {
  Future<Either<ApiErrorModel, SchedulesEntity>> loadUserSchedules({
    required DateTime date,
  });
}
