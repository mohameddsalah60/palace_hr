import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/cubit/home_cubit.dart';
import 'attendance_day_refresh.dart';
import 'history_days.dart';
import 'home_calendar.dart';
import 'home_view_header.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeViewHeader(),
        SizedBox(height: 16.h),
        CustomCalendar(
          focusedDate: context.watch<HomeCubit>().dateT,
          onDateChange: (date) {
            context.read<HomeCubit>().updateSelectedDay(date);
          },
        ),
        SizedBox(height: 16.h),
        AttendanceRefreshView(),
        SizedBox(height: 16.h),
        HistoryDays(),
      ],
    );
  }
}
