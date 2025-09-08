import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/widgets/custom_circular_progress_indicator.dart';
import 'package:palace_hr/features/dashboard/presentation/cubits/fetch_employe_attendance_cubit/fetch_employe_attendance_cubit.dart';
import 'package:palace_hr/generated/l10n.dart';

import 'activity_item.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      FetchEmployeAttendanceCubit,
      FetchEmployeAttendanceState
    >(
      builder: (context, state) {
        if (state is FetchEmployeAttendanceSuccsess) {
          if (state.attendance.isNotEmpty) {
            return SliverList.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: ActivityItem(attendance: state.attendance[index]),
                );
              },
              itemCount: state.attendance.length,
            );
          } else {
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_busy, size: 64.r, color: Colors.grey),
                    SizedBox(height: 16.h),
                    Text(
                      S.of(context).noAttendance,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
        } else if (state is FetchEmployeAttendanceLoading) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: CustomCircularProgressIndicator(color: AppColors.mainBlue),
            ),
          );
        } else if (state is FetchEmployeAttendanceFailure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Text(state.message),
            ),
          );
        } else {
          return SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }
}
