import '../helpers/is_english_locale_funcation.dart';

abstract class ErrorMessages {
  static String get cancellationMessage =>
      isEnglishLocale()
          ? 'Login process was cancelled.'
          : 'تم إلغاء عملية تسجيل الدخول.';

  static String get genericErrorMessage =>
      isEnglishLocale()
          ? 'Something went wrong. Please try again.'
          : 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  static String get noInternetConnectionMessage =>
      isEnglishLocale()
          ? 'No internet connection. Please check your connection.'
          : 'لا يوجد اتصال بالإنترنت. يرجى التحقق من الاتصال.';

  static String get serverErrorMessage =>
      isEnglishLocale()
          ? 'Server error. Please try again later.'
          : 'خطأ في الخادم. حاول مرة أخرى لاحقاً.';

  static String get unauthorizedMessage =>
      isEnglishLocale()
          ? 'Unauthorized access. Please log in again.'
          : 'دخول غير مصرح به. يرجى تسجيل الدخول مرة أخرى.';

  static String get emailNotFound =>
      isEnglishLocale()
          ? 'Email not found, please contact admin Palace HR'
          : 'البريد الإلكتروني غير موجود، يرجى التواصل مع مسؤول Palace HR.';

  static String getFirebaseErrorMessage(String errorCode) {
    if (isEnglishLocale()) {
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
    } else {
      switch (errorCode) {
        case 'network-request-failed':
          return 'تحقق من اتصالك بالإنترنت.';
        case 'user-disabled':
          return 'تم تعطيل حسابك.';
        case 'user-not-found':
          return 'لا يوجد حساب مرتبط بهذا البريد الإلكتروني.';
        case 'wrong-password':
          return 'البريد الإلكتروني أو كلمة المرور غير صحيحة.';
        case 'invalid-credential':
          return 'بيانات تسجيل الدخول غير صحيحة.';
        case 'invalid-email':
          return 'يرجى إدخال بريد إلكتروني صحيح.';
        case 'email-already-in-use':
          return 'هذا البريد مستخدم بالفعل. يرجى تسجيل الدخول.';
        case 'weak-password':
          return 'كلمة المرور ضعيفة جداً.';
        case 'account-exists-with-different-credential':
          return 'يوجد حساب مرتبط بمعلومات دخول مختلفة.';
        default:
          return genericErrorMessage;
      }
    }
  }
}
