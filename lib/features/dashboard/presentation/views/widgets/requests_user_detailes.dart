import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/di/getit_service_loacator.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/features/dashboard/domin/repos/dashboard_repo.dart';

import '../../../../../core/widgets/custom_circular_progress_indicator.dart';

import '../../cubits/fetch_employees_requests_cubit/fetch_employees_requests_cubit.dart';
import 'request_catogry_list.dart';
import 'requests_item.dart';

class RequestsUserDetailes extends StatelessWidget {
  const RequestsUserDetailes({super.key, required this.emailUser});
  final String emailUser;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              FetchEmployeesRequestsCubit(getIt<DashboardRepo>())
                ..fetchEmployeesRequests(email: emailUser),
      child: RequestsUserDetailesBody(),
    );
  }
}

class RequestsUserDetailesBody extends StatelessWidget {
  const RequestsUserDetailesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        RequestCatogryList(),
        SizedBox(height: 16.h),
        BlocBuilder<FetchEmployeesRequestsCubit, FetchEmployeesRequestsState>(
          builder: (context, state) {
            if (state is FetchEmployeesRequestSuccess) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: state.requests.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: RequestsItem(
                        requestUserInputEntity: state.requests[index],
                      ),
                    );
                  },
                ),
              );
            } else if (state is FetchEmployeesRequestsFailure) {
              Center(child: Text(state.message));
            }
            return CustomCircularProgressIndicator(color: AppColors.mainBlue);
          },
        ),
      ],
    );
  }
}
