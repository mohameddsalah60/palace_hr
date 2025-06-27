import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../request_cubit/request_cubit.dart';

class UserRequestSumbitButton extends StatelessWidget {
  const UserRequestSumbitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestCubit, RequestState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              state is RequestLoadingState
                  ? null
                  : context.read<RequestCubit>().verifyRequestParameters();
            },
            icon: state is RequestLoadingState ? null : Icon(Icons.send),
            label:
                state is RequestLoadingState
                    ? Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                    : Text(
                      S.of(context).submitRequest,
                      style: TextStyle(fontSize: 16.sp),
                    ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14.r),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              backgroundColor: AppColors.mainBlue,
              foregroundColor: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
