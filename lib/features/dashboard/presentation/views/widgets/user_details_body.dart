import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/di/getit_service_loacator.dart';

import 'package:palace_hr/features/auth/domin/entites/user_entity.dart';
import 'package:palace_hr/features/dashboard/domin/repos/dashboard_repo.dart';
import 'package:palace_hr/features/dashboard/presentation/cubits/fetch_employe_attendance_cubit/fetch_employe_attendance_cubit.dart';

import 'activity_list.dart';
import 'user_details_card.dart';

class UserDetailsBody extends StatelessWidget {
  const UserDetailsBody({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.r),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 8.h)),
          SliverToBoxAdapter(child: UserDetailsCard(user: user)),
          SliverToBoxAdapter(child: SizedBox(height: 8.h)),
          BlocProvider(
            create:
                (context) =>
                    FetchEmployeAttendanceCubit(getIt<DashboardRepo>())
                      ..fetchEmployeAttendance(employeeEmail: user.email),
            child: ActivityList(),
          ),
        ],
      ),
    );
  }
}
