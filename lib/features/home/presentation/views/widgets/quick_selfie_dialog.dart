import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/get_user.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../generated/l10n.dart';

void quickSelfieDialog(BuildContext context) {
  final faceIdUrl = getUser().faceIdUrl;

  if (faceIdUrl == null || faceIdUrl.isEmpty) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final s = S.of(context);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.wheit,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 24.h,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.celebration, color: Colors.green, size: 48.r),
                SizedBox(height: 16.h),
                Text(
                  s.loginSuccessTitle,
                  style: AppTextStyles.fontWeight600Size16.copyWith(
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                Text(
                  s.selfieRequestBody,
                  style: AppTextStyles.fontWeight400Size14.copyWith(
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                CustomButton(
                  onPressed: () {
                    // Call selfie capture
                    Navigator.of(context).pop();
                  },
                  text: s.startButton,
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
