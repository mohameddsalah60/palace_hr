import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../generated/l10n.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      children: [
        buildValidationRow(s.passwordLowercase, hasLowerCase),
        SizedBox(height: 4.h),
        buildValidationRow(s.passwordUppercase, hasUpperCase),
        SizedBox(height: 4.h),
        buildValidationRow(s.passwordSpecialChar, hasSpecialCharacters),
        SizedBox(height: 4.h),
        buildValidationRow(s.passwordNumber, hasNumber),
        SizedBox(height: 4.h),
        buildValidationRow(s.passwordMinLength, hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        const CircleAvatar(radius: 2.5, backgroundColor: AppColors.grey),
        SizedBox(width: 6),
        Text(
          text,
          style: AppTextStyles.fontWeight400Size14.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidated ? AppColors.grey : Colors.black,
          ),
        ),
      ],
    );
  }
}
