import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

class AttendanceDayItem extends StatelessWidget {
  const AttendanceDayItem({
    super.key,
    required this.txt,
    required this.txt2,
    required this.time,
    required this.color,
    this.onTap,
  });
  final String txt, txt2, time;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width * .4,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.wheitDark,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 6.r),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Icon(Icons.login, color: Colors.white, size: 26),
                ),
                SizedBox(width: 8.w),
                Text(
                  txt,
                  style: AppTextStyles.fontWeight400Size14.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),
            Text(
              time,
              style: AppTextStyles.fontWeight700Size24.copyWith(
                color: AppColors.black,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              txt2,
              style: AppTextStyles.fontWeight500Size14.copyWith(
                color: AppColors.greyDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
