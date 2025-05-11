import 'package:flutter/material.dart';
import 'package:palace_hr/core/helpers/extinctions.dart';
import 'package:palace_hr/generated/l10n.dart';

import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            context.pushNamed(AppRoutes.forgetPassword);
          },
          child: Text(
            S.of(context).forgetPassword,
            style: AppTextStyles.fontWeight400Size12.copyWith(
              color: AppColors.mainBlue,
            ),
          ),
        ),
      ],
    );
  }
}
