import 'package:flutter/material.dart';
import 'package:palace_hr/core/helpers/is_english_locale_funcation.dart';

import '../../../../core/utils/app_colors.dart';

class SettingsItem {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color titleColor;

  SettingsItem({
    required this.title,
    required this.icon,
    this.iconColor = AppColors.mainBlue,
    this.titleColor = AppColors.black,
  });
}

final List<SettingsItem> settingsItems = [
  // General
  SettingsItem(
    title: isEnglishLocale() ? "Change Language" : "تغير اللغة",
    icon: Icons.language,
  ),
  SettingsItem(
    title: isEnglishLocale() ? "About App" : "حول التطبيق",
    icon: Icons.info_outline,
  ),
];
