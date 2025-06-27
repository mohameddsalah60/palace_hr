import 'dart:developer';

import 'package:palace_hr/features/requests/domin/entites/request_user_input_entity.dart';
import 'package:palace_hr/features/requests/domin/repo/request_repo.dart';

import '../../../core/errors/api_error_handler.dart';
import '../../../core/errors/exceptions.dart';

class RequestHandler {
  final RequestRepo repo;

  RequestHandler({required this.repo});

  Future<void> addRequestOverTime(DateTime date) async {
    final difference = DateTime.now().difference(date);

    if (difference.inMinutes >= 30) {
      try {
        final result = await repo.createRequest(
          requestUserInputEntity: RequestUserInputEntity(
            requestCreatedAt: DateTime.now(),
            requestDateDay: date,
            requestType: 'Overtime',
            requestFromDate: DateTime.now(),
            requestToDate: date,
            requestNotes:
                difference.inMinutes < 60
                    ? '${difference.inMinutes} minutes'
                    : '${(difference.inMinutes / 60).toStringAsFixed(1)} hours',
          ),
        );

        result.fold(
          (f) {
            throw CustomException(message: f.errMessage);
          },
          (_) {
            log("Delay penalty added.");
          },
        );
      } catch (e) {
        log(e.toString());
        throw CustomException(
          message: ApiErrorHandler.handleError(e).errMessage,
        );
      }
    }
  }
}
