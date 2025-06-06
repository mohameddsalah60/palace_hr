import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/widgets/custom_widget_frame.dart';
import 'package:palace_hr/features/home/domin/entites/schedules_entity.dart';
import 'package:palace_hr/features/home/presentation/cubits/cubit/home_cubit.dart';

import '../../../../../core/utils/app_text_styles.dart';

class HistoryDays extends StatelessWidget {
  const HistoryDays({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        String checkInTime = context.read<HomeCubit>().checkInTime;
        String checkOutTime = context.read<HomeCubit>().checkOutTime;
        DayEntity dayEntity =
            context.read<HomeCubit>().dayEntity ??
            DayEntity(
              day: DateTime.now().day,
              times: {"start": DateTime.now(), "end": DateTime.now()},
              isOffDay: true,
            );
        return dayEntity.isOffDay
            ? SizedBox.shrink()
            : StyledWidgetFrame(
              child: Row(
                children: [
                  checkInTime == '--:--:--'
                      ? CircleAvatar(
                        radius: 16.r,
                        backgroundColor: Colors.orangeAccent,
                        child: Icon(
                          FontAwesomeIcons.exclamation,
                          color: AppColors.wheit,
                        ),
                      )
                      : CircleAvatar(
                        radius: 16.r,
                        backgroundColor: AppColors.mainBlue,
                        child: Icon(Icons.check, color: AppColors.wheit),
                      ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${dayEntity.pad(dayEntity.day)} ${dayEntity.monthName(dayEntity.times['start']!.month)}',
                        style: AppTextStyles.fontWeight700Size24.copyWith(
                          color: AppColors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        dayEntity.weekdayName(
                          dayEntity.times['start']!.weekday,
                        ),
                        style: AppTextStyles.fontWeight400Size14.copyWith(
                          color: AppColors.greyDark,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // دخول
                  _buildTimeColumn(
                    time: checkInTime.isEmpty ? '--:--:--' : checkInTime,
                    icon: Icons.login,
                    color: Colors.green,
                  ),
                  SizedBox(width: 20.w),
                  // خروج
                  _buildTimeColumn(
                    time: checkOutTime.isEmpty ? '--:--:--' : checkOutTime,
                    icon: Icons.logout,
                    color: Colors.red,
                  ),
                ],
              ),
            );
      },
    );
  }

  Widget _buildTimeColumn({
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(height: 4),
        Text(
          time,
          style: AppTextStyles.fontWeight600Size16.copyWith(fontSize: 14.sp),
        ),
      ],
    );
  }
}
