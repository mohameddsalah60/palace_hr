import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/di/getit_service_loacator.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/widgets/custom_app_bar.dart';
import 'package:palace_hr/core/widgets/custom_snackbar.dart';
import 'package:palace_hr/features/requests/domin/repo/request_repo.dart';
import 'package:palace_hr/features/requests/presentation/request_cubit/request_cubit.dart';

import '../../../../generated/l10n.dart';
import 'widgets/user_request_details.dart';
import 'widgets/user_request_info_list.dart';

class UserRequestView extends StatelessWidget {
  const UserRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.wheitDark,
      appBar: buildAppBar(context, title: S.of(context).newRequest),
      body: BlocProvider(
        create: (context) => RequestCubit(getIt<RequestRepo>())..getDataUser(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserRequestInfoList(),
              SizedBox(height: 24.h),
              RequestDetails(),
              UserRequestViewBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserRequestViewBlocListener extends StatelessWidget {
  const UserRequestViewBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestCubit, RequestState>(
      listener: (context, state) {
        if (state is RequestErrorState) {
          customSnackBar(context: context, message: state.message);
        } else if (state is RequestSuccessState) {
          customSnackBar(
            context: context,
            message: S.of(context).requestSentSuccessfully,
            color: Colors.green,
          );
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
