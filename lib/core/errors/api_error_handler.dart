import 'package:firebase_auth/firebase_auth.dart';

import 'api_error_model.dart';
import 'errors_messages.dart';

class ApiErrorHandler {
  static ApiErrorModel handleError(dynamic error) {
    if (error is FirebaseAuthException) {
      if (error.code.contains('Null')) {
        return ServerFailure(errMessage: ErrorMessages.cancellationMessage);
      } else {
        return ServerFailure(
          errMessage: ErrorMessages.getFirebaseErrorMessage(error.code),
        );
      }
    } else if (error is Map<String, dynamic>) {
      return error['message'] ?? 'Unknown error';
    } else if (error is Exception) {
      return ServerFailure(errMessage: error.toString());
    } else {
      return ServerFailure(errMessage: ErrorMessages.genericErrorMessage);
    }
  }
}
