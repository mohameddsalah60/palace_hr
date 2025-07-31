import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

import 'package:palace_hr/core/widgets/custom_search_field.dart';
import 'package:palace_hr/features/dashboard/presentation/cubits/fetch_employees_cubit/fetch_employees_cubit.dart';
import 'package:palace_hr/generated/l10n.dart';

import 'dashboard_employees_header.dart';
import 'employees_list.dart';

class AllEmployeesBody extends StatelessWidget {
  const AllEmployeesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [DashboardEmployeeHeader(), TotalAndSearchEmployees()],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: EmployeesList(),
        ),
      ],
    );
  }
}

class TotalAndSearchEmployees extends StatelessWidget {
  const TotalAndSearchEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Icon(Icons.group, color: Colors.white, size: 20),
              ),
              SizedBox(width: 8.w),
              Text(
                '${context.watch<FetchEmployeesCubit>().users.length} ${S.of(context).totalEmployees}',
                style: AppTextStyles.fontWeight600Size16.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CustomSearchField(
            hintText: S.of(context).hintSearchEmployee,
            onChanged: (text) {
              context.read<FetchEmployeesCubit>().search(text);
            },
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
