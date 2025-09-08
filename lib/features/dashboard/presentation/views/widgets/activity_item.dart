import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';
import 'package:palace_hr/features/home/domin/entites/attendance_entity.dart';
import 'package:palace_hr/generated/l10n.dart';

import '../../../../../core/helpers/is_english_locale_funcation.dart';
import 'admin_control_attendance_popup_menu.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem({super.key, required this.attendance});
  final AttendanceEntity attendance;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: AppColors.wheit,

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 16.r),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.receipt_outlined,
                  size: 24.r,
                  color: AppColors.mainBlue,
                ),
                SizedBox(width: 12.w),
                Text(
                  '${pad(attendance.dateTime.day)} ${monthName(attendance.dateTime.month)}',

                  style: AppTextStyles.fontWeight600Size16.copyWith(
                    color: AppColors.black,
                  ),
                ),
                Spacer(),
                AdminControlAttendancePopupMenu(attendance: attendance),
              ],
            ),
            SizedBox(height: 8.h),
            Divider(thickness: 1.5, color: AppColors.greyDiveder),
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.wheitDark,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.all(16.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 16.w),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).checkIn,
                        style: AppTextStyles.fontWeight400Size14.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        attendance.checkIn,
                        style: AppTextStyles.fontWeight600Size16.copyWith(
                          color: AppColors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).checkOut,
                        style: AppTextStyles.fontWeight400Size14.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        attendance.checkOut!.isEmpty
                            ? "--:--:--"
                            : attendance.checkOut ?? "--:--:--",
                        style: AppTextStyles.fontWeight600Size16.copyWith(
                          color: AppColors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String monthName(int month) {
    const monthsAr = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    const monthsEn = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return isEnglishLocale() ? monthsEn[month - 1] : monthsAr[month - 1];
  }

  String pad(int n) => n.toString().padLeft(2, '0');
}
