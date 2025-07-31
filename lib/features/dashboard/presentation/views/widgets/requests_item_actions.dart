import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:palace_hr/core/utils/app_text_styles.dart';
import 'package:palace_hr/features/dashboard/presentation/cubits/cubit/fetch_employees_requests_cubit.dart';

import '../../../../requests/domin/entites/request_user_input_entity.dart';

class RequestsItemActions extends StatelessWidget {
  const RequestsItemActions({super.key, required this.requestUserInputEntity});
  final RequestUserInputEntity requestUserInputEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<FetchEmployeesRequestsCubit>().rejectedRequest(
                request: requestUserInputEntity,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.red.shade700,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              side: BorderSide(color: Colors.red.shade100),
            ),
            icon: Icon(Icons.cancel_outlined, size: 20.r),
            label: Text(
              'Reject',
              style: AppTextStyles.fontWeight500Size14.copyWith(
                color: Colors.red.shade700,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<FetchEmployeesRequestsCubit>().approveRequest(
                request: requestUserInputEntity,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade50,
              foregroundColor: Colors.green.shade700,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              side: BorderSide(color: Colors.green.shade100),
            ),
            icon: Icon(Icons.check_circle_outline, size: 20.r),
            label: Text(
              'Approve',
              style: AppTextStyles.fontWeight500Size14.copyWith(
                color: Colors.green.shade700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
