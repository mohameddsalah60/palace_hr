import 'package:flutter/material.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/widgets/custom_app_bar.dart';
import 'package:palace_hr/features/auth/domin/entites/user_entity.dart';
import 'package:palace_hr/generated/l10n.dart';

import 'widgets/user_details_body.dart';

class UserDetailsView extends StatelessWidget {
  const UserDetailsView({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.wheitDark,
      appBar: buildAppBar(context, title: s.employeeDetails),
      body: UserDetailsBody(user: user),
    );
  }
}
