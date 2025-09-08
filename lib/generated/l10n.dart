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

  /// `Loading....`
  String get loading {
    return Intl.message('Loading....', name: 'loading', desc: '', args: []);
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Image uploaded successfully`
  String get uploadedImage {
    return Intl.message(
      'Image uploaded successfully',
      name: 'uploadedImage',
      desc: '',
      args: [],
    );
  }

  /// `No penalties 🎉`
  String get Nopenalties {
    return Intl.message(
      'No penalties 🎉',
      name: 'Nopenalties',
      desc: '',
      args: [],
    );
  }

  /// `Keep it up, your work is excellent!`
  String get excellent {
    return Intl.message(
      'Keep it up, your work is excellent!',
      name: 'excellent',
      desc: '',
      args: [],
    );
  }

  /// `My Penalties`
  String get mypenalties {
    return Intl.message(
      'My Penalties',
      name: 'mypenalties',
      desc: '',
      args: [],
    );
  }

  /// `My Requests`
  String get myrequest {
    return Intl.message('My Requests', name: 'myrequest', desc: '', args: []);
  }

  /// `New Request`
  String get newRequest {
    return Intl.message('New Request', name: 'newRequest', desc: '', args: []);
  }

  /// `Permissions`
  String get permissions {
    return Intl.message('Permissions', name: 'permissions', desc: '', args: []);
  }

  /// `Annoul Leave`
  String get annualLeave {
    return Intl.message(
      'Annoul Leave',
      name: 'annualLeave',
      desc: '',
      args: [],
    );
  }

  /// `Sick Leave`
  String get sickLeave {
    return Intl.message('Sick Leave', name: 'sickLeave', desc: '', args: []);
  }

  /// `Request Details`
  String get requestDetails {
    return Intl.message(
      'Request Details',
      name: 'requestDetails',
      desc: '',
      args: [],
    );
  }

  /// `Select Request Type`
  String get selectRequestType {
    return Intl.message(
      'Select Request Type',
      name: 'selectRequestType',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message('Select Date', name: 'selectDate', desc: '', args: []);
  }

  /// `From Time`
  String get fromTime {
    return Intl.message('From Time', name: 'fromTime', desc: '', args: []);
  }

  /// `To Time`
  String get toTime {
    return Intl.message('To Time', name: 'toTime', desc: '', args: []);
  }

  /// `Additional Notes (Optional)`
  String get additionalNotes {
    return Intl.message(
      'Additional Notes (Optional)',
      name: 'additionalNotes',
      desc: '',
      args: [],
    );
  }

  /// `Upload Attachment (Optional)`
  String get uploadAttachment {
    return Intl.message(
      'Upload Attachment (Optional)',
      name: 'uploadAttachment',
      desc: '',
      args: [],
    );
  }

  /// `Submit Request`
  String get submitRequest {
    return Intl.message(
      'Submit Request',
      name: 'submitRequest',
      desc: '',
      args: [],
    );
  }

  /// `Your request was sent successfully.`
  String get requestSentSuccessfully {
    return Intl.message(
      'Your request was sent successfully.',
      name: 'requestSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `You haven't submitted any requests yet.`
  String get noRequestsMessage {
    return Intl.message(
      'You haven\'t submitted any requests yet.',
      name: 'noRequestsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `General`
  String get General {
    return Intl.message('General', name: 'General', desc: '', args: []);
  }

  /// `Account`
  String get Account {
    return Intl.message('Account', name: 'Account', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `About the App`
  String get aboutApp {
    return Intl.message('About the App', name: 'aboutApp', desc: '', args: []);
  }

  /// `Palace HR | Human Resources Management`
  String get aboutAppTitle {
    return Intl.message(
      'Palace HR | Human Resources Management',
      name: 'aboutAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `An app that helps employees track attendance, submit requests, and receive notifications easily with a simple UI and smooth UX.`
  String get aboutAppDescription {
    return Intl.message(
      'An app that helps employees track attendance, submit requests, and receive notifications easily with a simple UI and smooth UX.',
      name: 'aboutAppDescription',
      desc: '',
      args: [],
    );
  }

  /// `🕒 Easily log your daily check-ins and check-outs.`
  String get feature1 {
    return Intl.message(
      '🕒 Easily log your daily check-ins and check-outs.',
      name: 'feature1',
      desc: '',
      args: [],
    );
  }

  /// `📤 Submit leave or task requests in one tap.`
  String get feature2 {
    return Intl.message(
      '📤 Submit leave or task requests in one tap.',
      name: 'feature2',
      desc: '',
      args: [],
    );
  }

  /// `📄 Track the status of your requests in real time.`
  String get feature3 {
    return Intl.message(
      '📄 Track the status of your requests in real time.',
      name: 'feature3',
      desc: '',
      args: [],
    );
  }

  /// `🔔 Receive instant alerts for any updates.`
  String get feature4 {
    return Intl.message(
      '🔔 Receive instant alerts for any updates.',
      name: 'feature4',
      desc: '',
      args: [],
    );
  }

  /// `🔒 Full protection and privacy of your data.`
  String get feature5 {
    return Intl.message(
      '🔒 Full protection and privacy of your data.',
      name: 'feature5',
      desc: '',
      args: [],
    );
  }

  /// `Want to delete your account?`
  String get deleteAccountPrompt {
    return Intl.message(
      'Want to delete your account?',
      name: 'deleteAccountPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Account Deletion`
  String get confirmDeleteTitle {
    return Intl.message(
      'Confirm Account Deletion',
      name: 'confirmDeleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to permanently delete your account? This action cannot be undone.`
  String get confirmDeleteContent {
    return Intl.message(
      'Are you sure you want to permanently delete your account? This action cannot be undone.',
      name: 'confirmDeleteContent',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Version 1.0.0 • Developed by Palace HR Team`
  String get appVersion_ {
    return Intl.message(
      'Version 1.0.0 • Developed by Palace HR Team',
      name: 'appVersion_',
      desc: '',
      args: [],
    );
  }

  /// `User Profile`
  String get userProfile {
    return Intl.message(
      'User Profile',
      name: 'userProfile',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Phone Number`
  String get phoneLabel {
    return Intl.message('Phone Number', name: 'phoneLabel', desc: '', args: []);
  }

  /// `Job Title`
  String get jobTitleLabel {
    return Intl.message('Job Title', name: 'jobTitleLabel', desc: '', args: []);
  }

  /// `Find employee by name, email, or phone`
  String get hintSearchEmployee {
    return Intl.message(
      'Find employee by name, email, or phone',
      name: 'hintSearchEmployee',
      desc: '',
      args: [],
    );
  }

  /// `👋 Welcome to`
  String get welcomeTo {
    return Intl.message('👋 Welcome to', name: 'welcomeTo', desc: '', args: []);
  }

  /// `Dashboard Palace HR`
  String get dashboardHr {
    return Intl.message(
      'Dashboard Palace HR',
      name: 'dashboardHr',
      desc: '',
      args: [],
    );
  }

  /// `Total Employees`
  String get totalEmployees {
    return Intl.message(
      'Total Employees',
      name: 'totalEmployees',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get request {
    return Intl.message('Requests', name: 'request', desc: '', args: []);
  }

  /// `Add New User`
  String get addUser {
    return Intl.message('Add New User', name: 'addUser', desc: '', args: []);
  }

  /// `Employee Details`
  String get employeeDetails {
    return Intl.message(
      'Employee Details',
      name: 'employeeDetails',
      desc: '',
      args: [],
    );
  }

  /// `Edit Shift`
  String get editShift {
    return Intl.message('Edit Shift', name: 'editShift', desc: '', args: []);
  }

  /// `Penalties`
  String get penalties {
    return Intl.message('Penalties', name: 'penalties', desc: '', args: []);
  }

  /// `Change shift for the whole month`
  String get changeForWholeMonth {
    return Intl.message(
      'Change shift for the whole month',
      name: 'changeForWholeMonth',
      desc: '',
      args: [],
    );
  }

  /// `Change shift for the selected day`
  String get changeForSelectedDay {
    return Intl.message(
      'Change shift for the selected day',
      name: 'changeForSelectedDay',
      desc: '',
      args: [],
    );
  }

  /// `Mark day as off`
  String get markDayAsOff {
    return Intl.message(
      'Mark day as off',
      name: 'markDayAsOff',
      desc: '',
      args: [],
    );
  }

  /// `Shift changed successfully`
  String get shiftChanged {
    return Intl.message(
      'Shift changed successfully',
      name: 'shiftChanged',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Check-in`
  String get cancelCheckin {
    return Intl.message(
      'Cancel Check-in',
      name: 'cancelCheckin',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Check-out`
  String get cancelCheckout {
    return Intl.message(
      'Cancel Check-out',
      name: 'cancelCheckout',
      desc: '',
      args: [],
    );
  }

  /// `No attendance found this month`
  String get noAttendance {
    return Intl.message(
      'No attendance found this month',
      name: 'noAttendance',
      desc: '',
      args: [],
    );
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
