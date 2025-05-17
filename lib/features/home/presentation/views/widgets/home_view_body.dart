import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/features/home/presentation/views/widgets/home_calendar.dart';

import 'attendance_day.dart';
import 'home_view_header.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeViewHeader(),
        SizedBox(height: 16.h),
        HomeCalendar(),
        SizedBox(height: 16.h),
        AttendanceDay(),
      ],
    );
  }
}
