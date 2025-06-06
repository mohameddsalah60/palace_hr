import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../cubits/cubit/home_cubit.dart';
import 'attendance_day.dart';
import 'custom_header_refresh.dart';

class AttendanceRefreshView extends StatelessWidget {
  const AttendanceRefreshView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: SmartRefresher(
        controller: context.read<HomeCubit>().refreshController,
        enablePullDown: true,
        header: CustomHeaderRefresh(),
        onLoading: context.read<HomeCubit>().onLoading,
        onRefresh: context.read<HomeCubit>().onRefresh,
        child: AttendanceDay(),
      ),
    );
  }
}
