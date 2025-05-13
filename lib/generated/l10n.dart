// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Palace Hotel HR`
  String get palaceHR {
    return Intl.message(
      'Palace Hotel HR',
      name: 'palaceHR',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back! \nPlease login to your account.`
  String get welcomeBackMessage {
    return Intl.message(
      'Welcome back! \nPlease login to your account.',
      name: 'welcomeBackMessage',
      desc: '',
      args: [],
    );
  }

  /// `Palace HR is a comprehensive human resources management system designed to streamline HR processes and enhance employee engagement.`
  String get appDescription {
    return Intl.message(
      'Palace HR is a comprehensive human resources management system designed to streamline HR processes and enhance employee engagement.',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `Version 1.0.0`
  String get appVersion {
    return Intl.message(
      'Version 1.0.0',
      name: 'appVersion',
      desc: '',
      args: [],
    );
  }

  /// `Login process was cancelled.`
  String get cancellationMessage {
    return Intl.message(
      'Login process was cancelled.',
      name: 'cancellationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get genericErrorMessage {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'genericErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection. Please check your connection.`
  String get noInternetConnectionMessage {
    return Intl.message(
      'No internet connection. Please check your connection.',
      name: 'noInternetConnectionMessage',
      desc: '',
      args: [],
    );
  }

  /// `Server error. Please try again later.`
  String get serverErrorMessage {
    return Intl.message(
      'Server error. Please try again later.',
      name: 'serverErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized access. Please log in again.`
  String get unauthorizedMessage {
    return Intl.message(
      'Unauthorized access. Please log in again.',
      name: 'unauthorizedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Email not found, please contact admin Palace HR`
  String get emailNotFound {
    return Intl.message(
      'Email not found, please contact admin Palace HR',
      name: 'emailNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection.`
  String get networkRequestFailed {
    return Intl.message(
      'Check your internet connection.',
      name: 'networkRequestFailed',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been disabled.`
  String get userDisabled {
    return Intl.message(
      'Your account has been disabled.',
      name: 'userDisabled',
      desc: '',
      args: [],
    );
  }

  /// `No account found with this email.`
  String get userNotFound {
    return Intl.message(
      'No account found with this email.',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password.`
  String get wrongPassword {
    return Intl.message(
      'Incorrect email or password.',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid credentials provided.`
  String get invalidCredential {
    return Intl.message(
      'Invalid credentials provided.',
      name: 'invalidCredential',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `This email is already registered. Please log in.`
  String get emailAlreadyInUse {
    return Intl.message(
      'This email is already registered. Please log in.',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `The password is too weak.`
  String get weakPassword {
    return Intl.message(
      'The password is too weak.',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `An account already exists with a different credential.`
  String get accountExistsWithDifferentCredential {
    return Intl.message(
      'An account already exists with a different credential.',
      name: 'accountExistsWithDifferentCredential',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 lowercase letter`
  String get passwordLowercase {
    return Intl.message(
      'At least 1 lowercase letter',
      name: 'passwordLowercase',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 uppercase letter`
  String get passwordUppercase {
    return Intl.message(
      'At least 1 uppercase letter',
      name: 'passwordUppercase',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 special character`
  String get passwordSpecialChar {
    return Intl.message(
      'At least 1 special character',
      name: 'passwordSpecialChar',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 number`
  String get passwordNumber {
    return Intl.message(
      'At least 1 number',
      name: 'passwordNumber',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters long`
  String get passwordMinLength {
    return Intl.message(
      'At least 8 characters long',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `By logging, you agree to our `
  String get termsIntro {
    return Intl.message(
      'By logging, you agree to our ',
      name: 'termsIntro',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsTitle {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsTitle',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get andWord {
    return Intl.message(' and ', name: 'andWord', desc: '', args: []);
  }

  /// `Privacy Policy.`
  String get privacyPolicyTitle {
    return Intl.message(
      'Privacy Policy.',
      name: 'privacyPolicyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `This field password number is required.`
  String get passwordRequired {
    return Intl.message(
      'This field password number is required.',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid password.`
  String get passwordInvalid {
    return Intl.message(
      'Please enter a valid password.',
      name: 'passwordInvalid',
      desc: '',
      args: [],
    );
  }

  /// `This field email is required.`
  String get emailRequired {
    return Intl.message(
      'This field email is required.',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get emailInvalid {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'emailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get emailDomainInvalid {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'emailDomainInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Don’t worry, just enter your email and we’ll send you a verification code.`
  String get forgetPasswordInstruction {
    return Intl.message(
      'Don’t worry, just enter your email and we’ll send you a verification code.',
      name: 'forgetPasswordInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Forget Password`
  String get forgetPassword_ {
    return Intl.message(
      'Forget Password',
      name: 'forgetPassword_',
      desc: '',
      args: [],
    );
  }

  /// `Verification code sent to your email`
  String get verificationCodeSent {
    return Intl.message(
      'Verification code sent to your email',
      name: 'verificationCodeSent',
      desc: '',
      args: [],
    );
  }

  /// `Login successful`
  String get LoginSuccess {
    return Intl.message(
      'Login successful',
      name: 'LoginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Day Attendance`
  String get attendanceToday {
    return Intl.message(
      'Day Attendance',
      name: 'attendanceToday',
      desc: '',
      args: [],
    );
  }

  /// `Check-in`
  String get checkIn {
    return Intl.message('Check-in', name: 'checkIn', desc: '', args: []);
  }

  /// `Present`
  String get present {
    return Intl.message('Present', name: 'present', desc: '', args: []);
  }

  /// `Check-out`
  String get checkOut {
    return Intl.message('Check-out', name: 'checkOut', desc: '', args: []);
  }

  /// `Departure`
  String get departure {
    return Intl.message('Departure', name: 'departure', desc: '', args: []);
  }

  /// `You’ve successfully loggedin `
  String get loginSuccessTitle {
    return Intl.message(
      'You’ve successfully loggedin ',
      name: 'loginSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `We need a quick selfie to recognize you and simplify the login process.`
  String get selfieRequestBody {
    return Intl.message(
      'We need a quick selfie to recognize you and simplify the login process.',
      name: 'selfieRequestBody',
      desc: '',
      args: [],
    );
  }

  /// `Start   📸`
  String get startButton {
    return Intl.message('Start   📸', name: 'startButton', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
