import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/di/getit_service_loacator.dart';
import 'package:palace_hr/core/widgets/custom_button.dart';
import 'package:palace_hr/core/widgets/custom_snackbar.dart';
import 'package:palace_hr/features/dashboard/domin/repos/dashboard_repo.dart';
import 'package:palace_hr/features/dashboard/presentation/cubits/employee_shift_changer_cubit/employee_shift_changer_cubit.dart';
import 'package:palace_hr/generated/l10n.dart';
import 'month_or_day_shift_selector.dart';
import 'set_day_select_off_day.dart';
import 'start_to_end_shift_changer.dart';
import 'table_calendar_shift_changer.dart';

class EmployeeShiftChanger extends StatelessWidget {
  const EmployeeShiftChanger({super.key, required this.emailUser});
  final String emailUser;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              EmployeeShiftChangerCubit(emailUser, getIt<DashboardRepo>())
                ..initCubit(),
      child: BlocListener<EmployeeShiftChangerCubit, EmployeeShiftChangerState>(
        listener: (context, state) {
          if (state is EmployeeShiftChangerError) {
            customSnackBar(context: context, message: state.message);
            Navigator.pop(context);
          } else if (state is EmployeeShiftChangerSuccess) {
            customSnackBar(
              context: context,
              message: S.of(context).shiftChanged,
              color: Colors.green,
            );
            Navigator.pop(context);
          }
        },
        child: EmployeeShiftChangerBody(),
      ),
    );
  }
}

class EmployeeShiftChangerBody extends StatelessWidget {
  const EmployeeShiftChangerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TableCalendarShiftChanger(),
        SizedBox(height: 12.h),
        MonthOrDayShiftSelector(),
        SizedBox(height: 16.h),
        SetDaySelectOffDay(),
        SizedBox(height: 16.h),
        StartTOEndShiftChanger(),
        SizedBox(height: 20.h),
        CustomButton(
          onPressed: () {
            context.read<EmployeeShiftChangerCubit>().setScheduleUserInput();
          },
          text: S.of(context).saveChanges,
          color: Colors.blue,
        ),
      ],
    );
  }
}
