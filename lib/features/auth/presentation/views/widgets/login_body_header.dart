import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/select_language_widget.dart';
import '../../../../../generated/l10n.dart';

class LoginBodyHeader extends StatelessWidget {
  const LoginBodyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50.h),
        Row(
          children: [
            Text(
              S.of(context).palaceHR,
              style: AppTextStyles.fontWeight700Size24,
            ),
            const Spacer(),
            SelectLanguageWidget(),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          S.of(context).welcomeBackMessage,
          style: AppTextStyles.fontWeight400Size14,
          maxLines: 3,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
