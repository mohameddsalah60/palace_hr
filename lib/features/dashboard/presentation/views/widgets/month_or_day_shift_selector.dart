import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:palace_hr/features/dashboard/presentation/cubits/employee_shift_changer_cubit/employee_shift_changer_cubit.dart';
import '../../../../../generated/l10n.dart';

class MonthOrDayShiftSelector extends StatelessWidget {
  const MonthOrDayShiftSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_month, color: Colors.blue),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              context.read<EmployeeShiftChangerCubit>().applyToMonth
                  ? S.of(context).changeForWholeMonth
                  : S.of(context).changeForSelectedDay,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
          Switch(
            value: context.watch<EmployeeShiftChangerCubit>().applyToMonth,
            activeColor: Colors.blue,
            onChanged: (val) {
              context.read<EmployeeShiftChangerCubit>().toggleApplyToMonth();
            },
          ),
        ],
      ),
    );
  }
}
