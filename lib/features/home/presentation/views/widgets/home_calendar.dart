import 'package:easy_date_timeline/easy_date_timeline.dart';
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
      child: EasyTheme(
        data: EasyTheme.of(context).copyWithState(
          selectedDayTheme: const DayThemeData(
            backgroundColor: AppColors.mainBlue, // اليوم المختار
          ),
          unselectedDayTheme: const DayThemeData(
            backgroundColor: Colors.white, // باقي الأيام
            foregroundColor: AppColors.black,
          ),
          disabledDayTheme: DayThemeData(
            backgroundColor: Colors.grey.shade200, // الأيام المعطلة
            foregroundColor: AppColors.black,
          ),
          selectedCurrentDayTheme: const DayThemeData(
            backgroundColor: AppColors.mainBlue, // اليوم الحالي لو مختار
            border: BorderSide(color: AppColors.wheit),
          ),
          unselectedCurrentDayTheme: const DayThemeData(
            backgroundColor: AppColors.wheit,
            foregroundColor: AppColors.black,
            border: BorderSide(color: AppColors.mainBlue),
          ),
        ),
        child: EasyDateTimeLinePicker(
          headerOptions: HeaderOptions(headerType: HeaderType.none),
          ignoreUserInteractionOnAnimating: true,
          firstDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
          lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),

          focusedDate: context.watch<HomeCubit>().dateT,
          locale: isEnglishLocale() ? Locale('en') : Locale('ar'),

          onDateChange: (date) {
            context.read<HomeCubit>().updateSelectedDay(date);
          },
        ),
      ),
    );
  }
}
