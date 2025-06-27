import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:palace_hr/core/errors/api_error_model.dart';

import 'package:palace_hr/features/requests/domin/entites/request_user_input_entity.dart';

import '../../../../core/errors/api_error_handler.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/helpers/get_user.dart';
import '../../../../core/networking/constants_database_path.dart';
import '../../../../core/networking/database_service.dart';
import '../../../../core/networking/storage_service.dart';
import '../../../../core/services/shared_preferences_service.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domin/repo/request_repo.dart';
import '../models/request_user_input_model.dart';

class RequestRepoImpl implements RequestRepo {
  final StorageService storageService;
  final DatabaseService databaseService;

  RequestRepoImpl({
    required this.storageService,
    required this.databaseService,
  });
  @override
  Future<Either<ApiErrorModel, void>> createRequest({
    required RequestUserInputEntity requestUserInputEntity,
  }) async {
    try {
      Map<String, dynamic> requestModel =
          RequestUserInputModel.fromEntity(requestUserInputEntity).toMap();

      if (!await getRequstsIfExists(
        subPathDocId:
            "${requestUserInputEntity.requestType}-${requestUserInputEntity.requestDateDay!.year}-${requestUserInputEntity.requestDateDay!.month}-${requestUserInputEntity.requestDateDay!.day}",
      )) {
        await databaseService.addData(
          data: requestModel,
          path: ConstantsDatabasePath.getUserData,
          docId: getUser().email,
          subPath: ConstantsDatabasePath.addUserRequest,
          subPathDocId:
              "${requestUserInputEntity.requestType}-${requestUserInputEntity.requestDateDay!.year}-${requestUserInputEntity.requestDateDay!.month}-${requestUserInputEntity.requestDateDay!.day}",
        );
        await updateUser(requestType: requestUserInputEntity.requestType);
      } else {
        throw CustomException(message: 'Request already exists for this date.');
      }

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
  Future<Either<ApiErrorModel, List<RequestUserInputEntity>>>
  fetchUserRequest() async {
    try {
      List<RequestUserInputEntity> requests = [];
      DateTime sortedStartDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        1,
      );

      DateTime sortedEndDate = DateTime(
        DateTime.now().month == 12
            ? (DateTime.now().year) + 1
            : (DateTime.now().year),
        DateTime.now().month == 12 ? 1 : (DateTime.now().month) + 1,
        1,
      );
      var response = await databaseService.getData(
        path: ConstantsDatabasePath.getUserData,
        uId: getUser().email,
        subPath: ConstantsDatabasePath.addUserRequest,
        query: {
          'orderBy': 'requestDateDay',
          'descending': true,
          'startAt': sortedStartDate.toIso8601String(),
          'endAt': sortedEndDate.toIso8601String(),
        },
      );
      for (var i in response) {
        RequestUserInputEntity request = RequestUserInputModel.fromJson(i);
        requests.add(request);
      }
      log(requests.toString());

      return right(requests);
    } catch (e) {
      log(e.toString());

      return left(
        ServerFailure(errMessage: ApiErrorHandler.handleError(e).errMessage),
      );
    }
  }

  Future<bool> getRequstsIfExists({required String subPathDocId}) async {
    final exists = await databaseService.checkIfDataExists(
      path: ConstantsDatabasePath.getUserData,
      docId: getUser().email,
      subPath: ConstantsDatabasePath.addUserRequest,
      subPathId: subPathDocId,
    );
    return exists;
  }

  @override
  Future<Either<ApiErrorModel, void>> cancelRequest({
    required RequestUserInputEntity request,
  }) async {
    try {
      String requestId =
          "${request.requestType}-${request.requestDateDay!.year}-${request.requestDateDay!.month}-${request.requestDateDay!.day}";

      await databaseService.deleteData(
        path: ConstantsDatabasePath.getUserData,
        uId: getUser().email,
        subPath: ConstantsDatabasePath.addUserRequest,
        subPathId: requestId,
      );
      await updateUser(requestType: request.requestType, isCanceld: true);

      return right(null);
    } catch (e) {
      log(e.toString());

      return left(
        ServerFailure(errMessage: ApiErrorHandler.handleError(e).errMessage),
      );
    }
  }

  Future<void> updateUser({
    required String requestType,
    bool? isCanceld,
  }) async {
    String? type;
    int? count;

    if (isCanceld == true) {
      if (requestType == 'Permissions') {
        if (getUser().countPermission <= 3) {
          type = 'countPermission';
          count = getUser().countPermission + 1;
        } else {
          return;
        }
      } else if (requestType == 'Annoul Leave') {
        if (getUser().countAnnualDays <= 22) {
          type = 'countAnnualDays';
          count = getUser().countAnnualDays + 1;
        } else {
          return;
        }
      }
    } else if (requestType == 'Permissions') {
      type = 'countPermission';
      count = getUser().countPermission - 1;
    } else if (requestType == 'Annoul Leave') {
      type = 'countAnnualDays';
      count = getUser().countAnnualDays - 1;
    } else if (requestType == 'Stick Leave') {
      return;
    }

    if (type != null && count != null) {
      await databaseService.updateData(
        path: 'users',
        uId: getUser().email,
        value: {type: count},
      );
    }

    await updateUserData(requestType: requestType, isCanceld: isCanceld);
  }

  Future<void> updateUserData({
    required String requestType,
    bool? isCanceld,
  }) async {
    var user = getUser();
    if (isCanceld == true) {
      if (requestType == 'Permissions') {
        if (user.countPermission == 3) {
          return;
        }
        user.countPermission = user.countPermission + 1;
      } else if (requestType == 'Annoul Leave') {
        if (user.countAnnualDays == 22) {
          return;
        }
        user.countAnnualDays = user.countAnnualDays + 1;
      }
    } else if (requestType == 'Permissions') {
      user.countPermission = user.countPermission - 1;
    } else if (requestType == 'Annoul Leave') {
      user.countAnnualDays = user.countAnnualDays - 1;
    }
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());

    await SharedPreferencesService.setData(
      key: ConstantsDatabasePath.userDataLocalStorage,
      value: jsonData,
    );
  }

  // @override
  // Stream<void> updateUserProfile() async* {
  //   try {
  //     final stream = databaseService.getStreamData(
  //       path: 'users',
  //       uId: getUser().email,
  //       subPath: 'Requests',
  //     );
  //     print('Stream started');
  //     await for (var data in stream) {
  //       log('Data received: $data');
  //       yield data;
  //     }
  //   } catch (e) {
  //     log('Error in stream: $e');
  //     yield* Stream.error(ApiErrorHandler.handleError(e));
  //   }
  // }
}
