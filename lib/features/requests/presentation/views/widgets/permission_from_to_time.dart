import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../../request_cubit/request_cubit.dart';
import 'custom_request_text_field.dart';

class PermissionFromToTime extends StatelessWidget {
  const PermissionFromToTime({super.key, required this.requestCubit});

  final RequestCubit requestCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomRequestTextField(
            hint: S.of(context).fromTime,
            controller: requestCubit.requestFromDateController,
            onTap:
                () => requestCubit.chooseTimeDate(
                  context,
                  requestCubit.requestFromDateController,
                ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CustomRequestTextField(
            hint: S.of(context).toTime,
            controller: requestCubit.requestToDateController,
            onTap:
                () => requestCubit.chooseTimeDate(
                  context,
                  requestCubit.requestToDateController,
                ),
          ),
        ),
      ],
    );
  }
}
