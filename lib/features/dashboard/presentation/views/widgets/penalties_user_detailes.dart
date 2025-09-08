import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/di/getit_service_loacator.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/widgets/custom_circular_progress_indicator.dart';
import 'package:palace_hr/features/dashboard/domin/repos/dashboard_repo.dart';

import '../../../../penalties/presentation/views/widgets/my_penalty_item.dart';
import '../../cubits/fetch_employee_penalties_cubit/fetch_employee_penalties_cubit.dart';

class PenaltiesUserDetailes extends StatelessWidget {
  const PenaltiesUserDetailes({super.key, required this.emailUser});
  final String emailUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              FetchEmployeePenaltiesCubit(getIt<DashboardRepo>())
                ..fetchPenalties(email: emailUser),
      child: PenaltiesUserDetailesBody(),
    );
  }
}

class PenaltiesUserDetailesBody extends StatelessWidget {
  const PenaltiesUserDetailesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        BlocBuilder<FetchEmployeePenaltiesCubit, FetchEmployeePenaltiesState>(
          builder: (context, state) {
            if (state is FetchPenaltiesSuccess) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: state.penalties.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: PenaltyItem(
                        title: state.penalties[index].title,
                        date:
                            "${state.penalties[index].date.year}-${state.penalties[index].date.month}-${state.penalties[index].date.day}",
                        description: state.penalties[index].description,
                        penaltyValue: state.penalties[index].value,
                      ),
                    );
                  },
                ),
              );
            } else if (state is FetchPenaltiesFailure) {
              return Center(child: Text(state.message));
            }
            return CustomCircularProgressIndicator(color: AppColors.mainBlue);
          },
        ),
      ],
    );
  }
}
