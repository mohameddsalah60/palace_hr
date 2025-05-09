import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: 'By logging, you agree to our ',
        style: AppTextStyles.fontWeight400Size14.copyWith(
          color: AppColors.greyDark,
        ),
        children: [
          TextSpan(
            text: 'Terms & Conditions',
            style: AppTextStyles.fontWeight500Size14.copyWith(
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: ' and ',
            style: AppTextStyles.fontWeight400Size14.copyWith(
              color: AppColors.greyDark,
            ),
          ),
          TextSpan(
            text: 'Privacy Policy .',
            style: AppTextStyles.fontWeight500Size14.copyWith(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
