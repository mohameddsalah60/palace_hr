import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/features/requests/presentation/fetch_requests_cubit/fetch_requests_cubit.dart';

import '../../../../../core/utils/app_text_styles.dart';
import '../../../domin/entites/request_user_input_entity.dart';

class RequestButtonCancelRequest extends StatelessWidget {
  const RequestButtonCancelRequest({super.key, required this.request});
  final RequestUserInputEntity request;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          context.read<FetchRequestsCubit>().cancelRequest(request);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[50],
          foregroundColor: Colors.red[700],
          padding: EdgeInsets.symmetric(vertical: 12.h),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          side: BorderSide(color: Colors.red.shade100),
        ),
        icon: Icon(Icons.cancel, size: 20.r),
        label: Text(
          'Cancel Request',
          style: AppTextStyles.fontWeight500Size14.copyWith(
            color: Colors.red[700],
          ),
        ),
      ),
    );
  }
}
