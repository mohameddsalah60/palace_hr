import 'package:flutter/material.dart';

import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';
import 'package:palace_hr/features/settings/domin/entites/settings_item.dart';

class SettingsTile extends StatelessWidget {
  final SettingsItem settingsItem;
  final void Function()? onTap;
  const SettingsTile({
    super.key,
    required this.settingsItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.wheit,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        leading: Container(
          decoration: BoxDecoration(
            color: settingsItem.iconColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            settingsItem.icon,
            color: settingsItem.iconColor,
            size: 20,
          ),
        ),
        title: Text(
          settingsItem.title,
          style: AppTextStyles.fontWeight500Size14.copyWith(
            color: settingsItem.titleColor,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.greyDark,
        ),
        onTap: onTap,
      ),
    );
  }
}
