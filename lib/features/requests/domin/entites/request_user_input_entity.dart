import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/helpers/is_english_locale_funcation.dart';

class RequestUserInputEntity {
  final String requestType;
  final String? requestNotes, requestStatus;
  final DateTime? requestFromDate,
      requestToDate,
      requestDateDay,
      requestCreatedAt;
  RequestUserInputEntity({
    this.requestCreatedAt,
    required this.requestType,
    this.requestStatus = 'pending',
    required this.requestDateDay,
    required this.requestFromDate,
    required this.requestToDate,
    required this.requestNotes,
  });
  DateTime parseStringToDate(String date) {
    return DateTime.parse(date);
  }

  DateTime parseTimeStringToDateTime(String date) {
    var timeDate = DateFormat('hh:mm a').parse(date);
    return timeDate;
  }

  String formatTime(DateTime? time) {
    if (time == null) return '--:--';
    String formatted = DateFormat(
      'hh:mm a',
      isEnglishLocale() ? 'en' : 'ar',
    ).format(time);

    return formatted.toString().padLeft(2, '0');
  }

  String monthName(int month) {
    const monthsAr = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    const monthsEn = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return isEnglishLocale() ? monthsEn[month - 1] : monthsAr[month - 1];
  }

  Color requestStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
