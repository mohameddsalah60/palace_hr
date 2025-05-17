import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

void showLoadingDialog(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (context) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.black,
                  strokeWidth: 3,
                ),
                SizedBox(width: 16.h),
                Text(
                  S.of(context).loading,
                  style: AppTextStyles.fontWeight400Size14.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  });
}
