import 'package:flutter/material.dart';
import 'package:palace_hr/generated/l10n.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: s.termsIntro,
        style: AppTextStyles.fontWeight400Size14.copyWith(
          color: AppColors.greyDark,
        ),
        children: [
          TextSpan(
            text: s.termsTitle,
            style: AppTextStyles.fontWeight500Size14.copyWith(
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: s.andWord,
            style: AppTextStyles.fontWeight400Size14.copyWith(
              color: AppColors.greyDark,
            ),
          ),
          TextSpan(
            text: s.privacyPolicyTitle,
            style: AppTextStyles.fontWeight500Size14.copyWith(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
