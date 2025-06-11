import '../../domin/repos/schedules_repo.dart';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:palace_hr/core/errors/api_error_model.dart';
import 'package:palace_hr/core/helpers/get_user.dart';
import 'package:palace_hr/core/networking/constants_database_path.dart';
import 'package:palace_hr/core/networking/database_service.dart';

import 'package:palace_hr/features/home/domin/entites/schedules_entity.dart';

import '../../../../core/errors/api_error_handler.dart';

import '../helpers/home_utils.dart';
import '../models/schedules_model.dart';

class SchedulesRepoImpl implements SchedulesRepo {
  final DatabaseService databaseService;

  SchedulesRepoImpl({required this.databaseService});
  @override
  Future<Either<ApiErrorModel, SchedulesEntity>> loadUserSchedules({
    required DateTime date,
  }) async {
    try {
      final formattedMonth =
          "${date.year}-${date.month.toString().padLeft(2, '0')}";
      final result = await HomeUtils.getData(
        databaseService: databaseService,
        path: ConstantsDatabasePath.getUserData,
        docId: getUser().email,
        subPath: ConstantsDatabasePath.getUserSchedule,
        subPathId: formattedMonth,
      );
      if (result == null) {
        log("No schedules found for user: ${getUser().email}");
        return left(
          ServerFailure(errMessage: "No schedules found for the user."),
        );
      }
      return right(SchedulesModel.fromJson(result));
    } catch (e) {
      return left(ApiErrorHandler.handleError(e));
    }
  }
}
