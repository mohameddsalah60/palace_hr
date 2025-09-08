import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:palace_hr/features/dashboard/presentation/cubits/employee_shift_changer_cubit/employee_shift_changer_cubit.dart';
import '../../../../../generated/l10n.dart';

class SetDaySelectOffDay extends StatelessWidget {
  const SetDaySelectOffDay({super.key});

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
          Icon(Icons.beach_access, color: Colors.orange),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              S.of(context).markDayAsOff,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
          Switch(
            value: context.watch<EmployeeShiftChangerCubit>().isDayOff,
            activeColor: Colors.orange,
            onChanged: (val) {
              context.read<EmployeeShiftChangerCubit>().toggleDayOff();
            },
          ),
        ],
      ),
    );
  }
}
