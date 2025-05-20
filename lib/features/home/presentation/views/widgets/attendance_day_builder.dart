import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../cubits/cubit/user_schedule_cubit.dart';
import 'attendance_day.dart';
import 'custom_header_refresh.dart';

class AttendanceDayBuilder extends StatelessWidget {
  const AttendanceDayBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.28,
      child: SmartRefresher(
        controller: context.read<UserScheduleCubit>().refreshController,
        enablePullDown: true,
        header: CustomHeaderRefresh(),
        onLoading: context.read<UserScheduleCubit>().onLoading,
        onRefresh: context.read<UserScheduleCubit>().onRefresh,
        child: BlocBuilder<UserScheduleCubit, UserScheduleState>(
          builder: (context, state) {
            if (state is UserScheduleSuccess) {
              return AttendanceDay(schedules: state.schedules);
            } else if (state is UserScheduleFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
