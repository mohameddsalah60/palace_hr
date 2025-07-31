import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/routing/app_routes.dart';

import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';
import 'package:palace_hr/features/settings/domin/entites/settings_item.dart';
import 'package:palace_hr/features/settings/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:palace_hr/features/settings/presentation/views/widgets/change_locale_bottom_sheet.dart';

import 'settings_tile.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<SettingsItem> items;

  const SettingsSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.fontWeight600Size16.copyWith(
            fontSize: 14.sp,
            color: AppColors.grey,
          ),
        ),
        SizedBox(height: 8.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(items.length, (index) {
            return SettingsTile(
              settingsItem: items[index],
              onTap: () {
                if (items[index].title == "Change Language" ||
                    items[index].title == "تغير اللغة") {
                  changeLocale(context);
                } else if (items[index].title == "Logout" ||
                    items[index].title == "تسجيل الخروج") {
                  // Handle logout logic here
                  context.read<LogoutCubit>().logoutUser();
                } else if (items[index].title == "About App" ||
                    items[index].title == "حول التطبيق") {
                  Navigator.pushNamed(context, AppRoutes.aboutApp);
                } else if (items[index].title == "Dashboard" ||
                    items[index].title == "وحدة التحكم") {
                  Navigator.pushNamed(context, AppRoutes.allEmployees);
                }
              },
            );
          }),
        ),
      ],
    );
  }
}
