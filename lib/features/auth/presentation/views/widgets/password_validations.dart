import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

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
    return Column(
      children: [
        buildValidationRow('At least 1 lowercase letter', hasLowerCase),
        SizedBox(height: 2),

        buildValidationRow('At least 1 uppercase letter', hasUpperCase),
        SizedBox(height: 2),

        buildValidationRow(
          'At least 1 special character',
          hasSpecialCharacters,
        ),
        SizedBox(height: 2),

        buildValidationRow('At least 1 number', hasNumber),
        SizedBox(height: 2),
        buildValidationRow('At least 8 characters long', hasMinLength),
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
