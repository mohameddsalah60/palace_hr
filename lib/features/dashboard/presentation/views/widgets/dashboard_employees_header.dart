import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/helpers/extinctions.dart';

import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

import '../../../../../generated/l10n.dart';

class DashboardEmployeeHeader extends StatelessWidget {
  const DashboardEmployeeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomWaveClipper(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        color: AppColors.mainBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 48.h),
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  color: AppColors.wheit.withValues(alpha: .65),
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_back_ios_sharp,
                  size: 22.sp,
                  color: AppColors.black.withValues(alpha: .65),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              S.of(context).welcomeTo,
              style: AppTextStyles.fontWeight500Size14.copyWith(
                color: AppColors.wheit,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              S.of(context).dashboardHr,
              style: AppTextStyles.fontWeight700Size16.copyWith(
                color: AppColors.wheit,
                fontSize: 24.sp,
              ),
            ),
            SizedBox(height: 36.h),
          ],
        ),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height - 30,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 60,
      size.width,
      size.height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
