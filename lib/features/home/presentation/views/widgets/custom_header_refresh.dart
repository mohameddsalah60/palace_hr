import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomHeaderRefresh extends StatelessWidget {
  const CustomHeaderRefresh({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (context, mode) {
        Widget body;
        switch (mode) {
          case RefreshStatus.idle:
            body = SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            );
            break;
          case RefreshStatus.refreshing:
            body = SizedBox(
              width: 32.w,
              height: 32.w,
              child: CircularProgressIndicator(color: AppColors.mainBlue),
            );
            break;
          case RefreshStatus.completed:
            body = Text("");
            break;
          case RefreshStatus.failed:
            body = Text("");
            break;
          case RefreshStatus.canRefresh:
            body = Text("");
            break;
          default:
            body = Text("");
        }
        return SizedBox(height: 60.0, child: Center(child: body));
      },
    );
  }
}
