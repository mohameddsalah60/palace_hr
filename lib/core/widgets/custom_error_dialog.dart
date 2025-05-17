import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomErrorDialog extends StatelessWidget {
  final String message;
  final void Function()? onPressed;
  const CustomErrorDialog({super.key, required this.message, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      titlePadding: EdgeInsets.only(top: 24.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      actionsPadding: EdgeInsets.only(bottom: 12.h),
      title: Center(
        child: Icon(Icons.error_outline, color: Colors.red, size: 48.r),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.fontWeight400Size14.copyWith(
          color: AppColors.grey,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: onPressed ?? () => Navigator.of(context).pop(),
          child: Text(
            'اوكي',
            style: AppTextStyles.fontWeight500Size14.copyWith(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
