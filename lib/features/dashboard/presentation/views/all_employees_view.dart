import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/core/di/getit_service_loacator.dart';
import 'package:palace_hr/core/utils/app_colors.dart';

import 'package:palace_hr/features/dashboard/domin/repos/dashboard_repo.dart';
import 'package:palace_hr/features/dashboard/presentation/cubits/fetch_employees_requests_cubit/fetch_employees_requests_cubit.dart';
import 'package:palace_hr/features/dashboard/presentation/cubits/fetch_employees_cubit/fetch_employees_cubit.dart';
import 'package:palace_hr/features/home/domin/entites/bottom_navigation_bar_entity.dart';
import 'package:palace_hr/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';

import 'widgets/all_employees_body.dart';
import 'widgets/requests_manage_body.dart';

class AllEmployeesView extends StatefulWidget {
  const AllEmployeesView({super.key});

  @override
  State<AllEmployeesView> createState() => _AllEmployeesViewState();
}

class _AllEmployeesViewState extends State<AllEmployeesView> {
  int _currentIndex = 0;
  late FetchEmployeesRequestsCubit fetchEmployeesRequestCubit;
  @override
  void initState() {
    fetchEmployeesRequestCubit = FetchEmployeesRequestsCubit(
      getIt<DashboardRepo>(),
    );
    super.initState();
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      fetchEmployeesRequestCubit.fetchEmployeesRequests();
    } else if (index == 2) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              FetchEmployeesCubit(getIt<DashboardRepo>())..fetchEmployees(),
      child: Scaffold(
        backgroundColor: AppColors.wheitSecondary,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            AllEmployeesBody(),
            BlocProvider.value(
              value: fetchEmployeesRequestCubit,
              child: ManageRequestsSection(),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onBottomNavTapped,
          list: adminPanelBottomNavigation,
        ),
      ),
    );
  }
}
