import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';
import 'package:palace_hr/core/widgets/custom_circular_progress_indicator.dart';
import 'package:palace_hr/core/widgets/custom_search_field.dart';
import 'package:palace_hr/features/dashboard/presentation/cubits/fetch_employees_requests_cubit/fetch_employees_requests_cubit.dart';
import 'package:palace_hr/generated/l10n.dart';

import 'request_catogry_list.dart';
import 'requests_item.dart';

class ManageRequestsSection extends StatelessWidget {
  const ManageRequestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.r),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    S.of(context).request,
                    style: AppTextStyles.fontWeight700Size24,
                  ),
                  SizedBox(height: 24.h),
                  CustomSearchField(
                    hintText: S.of(context).hintSearchEmployee,
                    onChanged: (query) {
                      context.read<FetchEmployeesRequestsCubit>().search(query);
                    },
                  ),
                  SizedBox(height: 18.h),
                  RequestCatogryList(),
                  SizedBox(height: 24.h),
                ],
              ),
            ),

            BlocBuilder<
              FetchEmployeesRequestsCubit,
              FetchEmployeesRequestsState
            >(
              builder: (context, state) {
                if (state is FetchEmployeesRequestSuccess) {
                  return SliverList.builder(
                    itemCount: state.requests.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: RequestsItem(
                          requestUserInputEntity: state.requests[index],
                        ),
                      );
                    },
                  );
                } else if (state is FetchEmployeesRequestsFailure) {
                  SliverToBoxAdapter(child: Center(child: Text(state.message)));
                }
                return SliverToBoxAdapter(
                  child: CustomCircularProgressIndicator(
                    color: AppColors.mainBlue,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
