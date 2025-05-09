import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_text_styles.dart';

class LoginBodyHeader extends StatelessWidget {
  const LoginBodyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50.h),
        Text('Palace Hotel HR', style: AppTextStyles.fontWeight700Size24),
        SizedBox(height: 8.h),
        Text(
          "Welcome back! \nPlease login to your account.",
          style: AppTextStyles.fontWeight400Size14,
          maxLines: 3,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
