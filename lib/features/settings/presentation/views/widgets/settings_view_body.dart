import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/helpers/get_user.dart';
import 'package:palace_hr/core/helpers/is_english_locale_funcation.dart';

import 'package:palace_hr/features/settings/domin/entites/settings_item.dart';

import '../../../../../generated/l10n.dart';
import 'settings_bloc_listener.dart';
import 'settings_section.dart';
import 'user_profile_header.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 8.r),
      child: CustomScrollView(
        slivers: [
          SettingsBlocListener(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                UserProfileHeader(),
                SizedBox(height: 24.h),
                SettingsSection(
                  title: S.of(context).General,
                  items: settingsItems,
                ),
                SizedBox(height: 32.h),
                SettingsSection(
                  title: S.of(context).Account,
                  items: [
                    SettingsItem(
                      title: isEnglishLocale() ? "Logout" : "تسجيل الخروج",
                      icon: Icons.logout,
                      iconColor: Colors.red,
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                getUser().isAdmin!
                    ? SettingsSection(
                      title: "Admin",
                      items: [
                        SettingsItem(
                          title:
                              isEnglishLocale() ? "Dashboard" : "وحدة التحكم",
                          icon: Icons.dashboard,
                          iconColor: Colors.orange,
                        ),
                      ],
                    )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
