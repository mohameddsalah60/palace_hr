import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/helpers/is_english_locale_funcation.dart';

class BottomNavigationBarEntity {
  final IconData icon;
  final String name;

  BottomNavigationBarEntity({required this.icon, required this.name});
}

List<BottomNavigationBarEntity> get bottomNavigationBarItem => [
  BottomNavigationBarEntity(
    icon: FontAwesomeIcons.userClock,
    name: isEnglishLocale() ? 'Schedule' : 'الجدول',
  ),
  BottomNavigationBarEntity(
    icon: FontAwesomeIcons.chartSimple,
    name: isEnglishLocale() ? 'Statistics' : 'الاحصائيات',
  ),
  BottomNavigationBarEntity(
    icon: FontAwesomeIcons.bookBookmark,
    name: isEnglishLocale() ? 'My Requests' : 'طلباتي',
  ),
  BottomNavigationBarEntity(
    icon: FontAwesomeIcons.bars,
    name: isEnglishLocale() ? 'Settings' : 'الاعدادات',
  ),
];
