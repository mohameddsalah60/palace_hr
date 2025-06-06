import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/helpers/extinctions.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';
import 'package:palace_hr/core/widgets/custom_circular_progress_indicator.dart';
import 'package:palace_hr/core/widgets/custom_widget_frame.dart';
import 'package:palace_hr/features/home/domin/entites/schedules_entity.dart';
import 'package:palace_hr/features/home/presentation/cubits/cubit/home_cubit.dart';

import '../../../../../core/widgets/custom_error_dialog.dart';
import '../../../../../generated/l10n.dart';
import 'attendance_day_item.dart';
import 'day_off_widget.dart';

class AttendanceDay extends StatelessWidget {
  const AttendanceDay({super.key});
  @override
  Widget build(BuildContext context) {
    return StyledWidgetFrame(
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeStateFailure) {
            showDialog(
              context: context,
              barrierDismissible: false,
              barrierColor: Colors.black.withValues(alpha: 0.3),
              builder:
                  (context) => CustomErrorDialog(
                    message: state.message,
                    onPressed: () {
                      context.pop();
                    },
                  ),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeStateLoading) {
            return CustomCircularProgressIndicator(color: AppColors.mainBlue);
          } else if (context.read<HomeCubit>().dayEntity == null ||
              context.read<HomeCubit>().dayEntity!.isOffDay) {
            return DayOffWidget();
          }
          return AttendanceDayBuilder(
            dayEntity: context.read<HomeCubit>().dayEntity!,
          );
        },
      ),
    );
  }
}

class AttendanceDayBuilder extends StatelessWidget {
  const AttendanceDayBuilder({super.key, required this.dayEntity});
  final DayEntity dayEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              time: dayEntity.formatTime(dayEntity.times['start']),
              color: Colors.teal.shade400,
              onTap: () {
                context.read<HomeCubit>().onCheckIn(
                  dateScheduled: (dayEntity.times['start']),
                );
              },
            ),
            SizedBox(width: 8.w),
            AttendanceDayItem(
              txt: S.of(context).checkOut,
              txt2: S.of(context).departure,
              time: dayEntity.formatTime(dayEntity.times['end']),
              color: Colors.red.shade400,
              onTap: () {
                context.read<HomeCubit>().onCheckOut(
                  dateScheduled: (dayEntity.times['end']),
                );
              },
            ),
          ],
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
