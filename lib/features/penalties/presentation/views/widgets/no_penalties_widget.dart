import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/generated/l10n.dart';

class NoPenaltiesWidget extends StatelessWidget {
  const NoPenaltiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 40.h),
      child: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 600),
        tween: Tween(begin: 0, end: 1),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, (1 - value) * 20),
              child: child,
            ),
          );
        },
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_outlined,
                  color: AppColors.mainBlue,
                  size: 64.sp,
                ),
                SizedBox(height: 16.h),
                Text(
                  S.of(context).Nopenalties,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Text(
                  S.of(context).excellent,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
