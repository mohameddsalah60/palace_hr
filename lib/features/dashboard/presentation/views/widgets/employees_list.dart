import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/helpers/extinctions.dart';
import 'package:palace_hr/core/routing/app_routes.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

import 'package:palace_hr/features/dashboard/presentation/cubits/fetch_employees_cubit/fetch_employees_cubit.dart';
import 'package:palace_hr/features/dashboard/presentation/views/widgets/employee_card.dart';

import '../../../../../core/widgets/custom_circular_progress_indicator.dart';

class EmployeesList extends StatelessWidget {
  const EmployeesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchEmployeesCubit, FetchEmployeesState>(
      builder: (context, state) {
        if (state is FetchEmployeesLoading) {
          return SliverToBoxAdapter(
            child: CustomCircularProgressIndicator(color: AppColors.mainBlue),
          );
        } else if (state is FetchEmployeesFailure) {
          return SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(state.message, style: AppTextStyles.fontWeight400Size14),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () {
                    context.read<FetchEmployeesCubit>().fetchEmployees();
                  },
                  child: Text(
                    'Retry Agein!',
                    style: AppTextStyles.fontWeight400Size14.copyWith(
                      color: AppColors.mainBlue,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is FetchEmployeesSuccess) {
          return SliverList.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(
                    AppRoutes.uaerDetails,
                    arguments: state.users[index],
                  );
                },
                child: EmployeeCard(
                  name: state.users[index].name,
                  email: state.users[index].email,
                  jobTitle: state.users[index].jobTitle,
                  imageUrl: state.users[index].faceIdUrl!,
                ),
              );
            },
            itemCount: state.users.length,
          );
        }
        return SliverToBoxAdapter(
          child: Text(
            'No Users now',
            style: AppTextStyles.fontWeight400Size14.copyWith(
              color: AppColors.mainBlue,
            ),
          ),
        );
      },
    );
  }
}
