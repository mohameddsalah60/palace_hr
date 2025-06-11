import 'dart:developer';

import 'package:palace_hr/core/errors/api_error_handler.dart';
import 'package:palace_hr/core/errors/exceptions.dart';

import '../domin/entites/penalty_entity.dart';
import '../domin/repo/penalties_repo.dart';

class PenaltyHandler {
  final PenaltiesRepo repo;

  PenaltyHandler(this.repo);

  Future<void> handleDelayPenalty(DateTime date) async {
    final difference = DateTime.now().difference(date);

    String value = _calculatePenaltyValue(difference.inMinutes);

    if (difference.inMinutes >= 15) {
      try {
        final result = await repo.addUserPenalty(
          penalty: PenaltyEntity(
            title: "Delay",
            description: "Late arrival (${difference.inMinutes} Minutes)",
            value: value,
            date: date,
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

  Future<void> handleAbsentPenalty(DateTime day) async {
    try {
      final result = await repo.addUserPenalty(
        penalty: PenaltyEntity(
          title: "Absent Penalty",
          description: "Absent",
          value: '1 Days',
          date: day,
        ),
      );

      result.fold(
        (f) {
          throw CustomException(message: f.errMessage);
        },
        (_) {
          log("Absent penalty added.");
        },
      );
    } catch (e) {
      log(e.toString());
      throw CustomException(message: ApiErrorHandler.handleError(e).errMessage);
    }
  }

  String _calculatePenaltyValue(int minutes) {
    if (minutes < 15) return "0";
    if (minutes <= 60) return "0.11";
    if (minutes <= 120) return "0.22";
    if (minutes <= 180) return "0.33";
    return "0.5";
  }
}
