import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

import '../../../../../generated/l10n.dart';
import 'attendance_day_item.dart';

class AttendanceDay extends StatelessWidget {
  const AttendanceDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
      decoration: ShapeDecoration(
        color: AppColors.wheit,
        shadows: [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 30,
            color: Color(0x19000000),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).attendanceToday,
            style: AppTextStyles.fontWeight700Size24.copyWith(
              fontSize: 16.sp,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AttendanceDayItem(
                txt: S.of(context).checkIn,
                txt2: S.of(context).present,
                time: '10:23 AM',
                color: Colors.teal.shade400,
              ),
              SizedBox(width: 8.w),
              AttendanceDayItem(
                txt: S.of(context).checkOut,
                txt2: S.of(context).departure,
                time: '7:00 PM',
                color: Colors.red.shade400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
