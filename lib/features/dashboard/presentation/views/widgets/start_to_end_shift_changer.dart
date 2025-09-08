import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:palace_hr/features/dashboard/presentation/cubits/employee_shift_changer_cubit/employee_shift_changer_cubit.dart';
import '../../../../../generated/l10n.dart';
import '../../../../requests/presentation/views/widgets/custom_request_text_field.dart';

class StartTOEndShiftChanger extends StatelessWidget {
  const StartTOEndShiftChanger({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomRequestTextField(
            hint: S.of(context).fromTime,
            controller:
                context
                    .read<EmployeeShiftChangerCubit>()
                    .shiftStartDateController,
            onTap: () {
              context.read<EmployeeShiftChangerCubit>().chooseTimeDate(
                context,
                context
                    .read<EmployeeShiftChangerCubit>()
                    .shiftStartDateController,
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CustomRequestTextField(
            hint: S.of(context).toTime,
            controller:
                context
                    .read<EmployeeShiftChangerCubit>()
                    .shiftEndDateController,
            onTap: () {
              context.read<EmployeeShiftChangerCubit>().chooseTimeDate(
                context,
                context
                    .read<EmployeeShiftChangerCubit>()
                    .shiftEndDateController,
              );
            },
          ),
        ),
      ],
    );
  }
}
