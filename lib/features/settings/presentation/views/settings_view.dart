import 'package:flutter/material.dart';

import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/widgets/custom_app_bar.dart';
import 'package:palace_hr/generated/l10n.dart';

import 'widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.wheitDark,
      appBar: buildAppBar(context, title: S.of(context).settings),
      body: SafeArea(child: SettingsViewBody()),
    );
  }
}
