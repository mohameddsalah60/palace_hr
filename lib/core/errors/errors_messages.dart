abstract class ErrorMessages {
  static const String cancellationMessage = 'Login process was cancelled.';
  static const String genericErrorMessage =
      'Something went wrong. Please try again.';
  static const String noInternetConnectionMessage =
      'No internet connection. Please check your connection.';
  static const String serverErrorMessage =
      'Server error. Please try again later.';
  static const String unauthorizedMessage =
      'Unauthorized access. Please log in again.';
  static const String emailNotFound =
      'Email not found, please contact admin Palace HR';

  static String getFirebaseErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'network-request-failed':
        return 'Check your internet connection.';
      case 'user-disabled':
        return 'Your account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect email or password.';
      case 'invalid-credential':
        return 'Invalid credentials provided.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'email-already-in-use':
        return 'This email is already registered. Please log in.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different credential.';
      default:
        return genericErrorMessage;
    }
  }
}
