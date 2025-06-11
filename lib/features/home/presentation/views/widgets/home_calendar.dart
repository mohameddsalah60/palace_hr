import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/is_english_locale_funcation.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../cubits/cubit/home_cubit.dart';

class HomeCalendar extends StatelessWidget {
  const HomeCalendar({super.key});
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
      child: CalendarTimeline(
        width: 70.w,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
        lastDate: DateTime(DateTime.now().year + 1),
        onDateSelected: (date) async {
          context.read<HomeCubit>().updateSelectedDay(date);
        },
        monthColor: AppColors.grey,
        dayColor: AppColors.grey,
        leftMargin: 5.r,
        activeDayColor: Colors.white,
        activeBackgroundDayColor: AppColors.mainBlue,
        locale: isEnglishLocale() ? 'en_US' : 'ar',
        fontSize: 18.sp,
        shrinkFontSize: 16.sp,
        dayNameFontSize: 12.sp,
      ),
    );
  }
}
