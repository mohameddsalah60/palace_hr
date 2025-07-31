import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';

import '../../../../../core/utils/app_text_styles.dart';

class UserDetailsButton extends StatelessWidget {
  const UserDetailsButton({
    super.key,
    required this.txt,
    required this.color,
    required this.iconData,
    this.onTap,
  });
  final String txt;
  final Color color;
  final IconData iconData;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120.w,
        decoration: BoxDecoration(
          color: AppColors.wheitDark,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(iconData, color: AppColors.backgroundScaffold),
            ),
            SizedBox(height: 12.h),
            Text(
              txt,
              style: AppTextStyles.fontWeight400Size14.copyWith(
                color: AppColors.black,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
