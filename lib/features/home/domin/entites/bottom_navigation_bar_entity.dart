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
    icon: FontAwesomeIcons.gavel,
    name: isEnglishLocale() ? 'My Penalties' : 'جزاتي',
  ),
  BottomNavigationBarEntity(
    icon: FontAwesomeIcons.clipboardList,
    name: isEnglishLocale() ? 'My Requests' : 'طلباتي',
  ),
  BottomNavigationBarEntity(
    icon: FontAwesomeIcons.bars,
    name: isEnglishLocale() ? 'Settings' : 'الاعدادات',
  ),
];
List<BottomNavigationBarEntity> get adminPanelBottomNavigation => [
  BottomNavigationBarEntity(
    icon: FontAwesomeIcons.userClock,
    name: isEnglishLocale() ? 'Employees' : 'الموظفون',
  ),

  BottomNavigationBarEntity(
    icon: FontAwesomeIcons.clipboardList,
    name: isEnglishLocale() ? 'Requests' : 'الطلبات',
  ),
];
