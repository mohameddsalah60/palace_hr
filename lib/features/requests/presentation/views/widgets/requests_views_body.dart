import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'request_status_indicator.dart';
import 'request_view_header.dart';
import 'requests_bloc_content.dart';

class RequestsViewBody extends StatelessWidget {
  const RequestsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          const RequestViewHeader(),
          SizedBox(height: 16.h),
          const RequestStatusIndicator(),
          SizedBox(height: 16.h),
          const Expanded(child: RequestsBlocContent()),
        ],
      ),
    );
  }
}
