import 'package:intl/intl.dart';

bool isEnglishLocale() {
  final locale = Intl.getCurrentLocale().toLowerCase();
  return locale.startsWith('en');
}
