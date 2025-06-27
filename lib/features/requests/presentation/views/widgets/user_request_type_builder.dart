import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../request_cubit/request_cubit.dart';
import 'permission_from_to_time.dart';

class RequestTypeBuilder extends StatelessWidget {
  const RequestTypeBuilder({super.key, required this.requestCubit});

  final RequestCubit requestCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestCubit, RequestState>(
      builder: (context, state) {
        if (requestCubit.requestTypeController == 'Permissions') {
          return Column(
            children: [
              PermissionFromToTime(requestCubit: requestCubit),
              SizedBox(height: 16.h),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
