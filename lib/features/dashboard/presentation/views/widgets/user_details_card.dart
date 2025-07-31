import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';

import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/network_circle_avatar_alt.dart';
import '../../../../auth/domin/entites/user_entity.dart';
import 'user_actions.dart';

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.wheit,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24.r),
          top: Radius.circular(24.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
        child: Column(
          children: [
            NetworkCircleAvatarAlt(imageUrl: user.faceIdUrl, radius: 50.r),
            SizedBox(height: 12.h),
            Text(
              user.name,
              style: AppTextStyles.fontWeight700Size24.copyWith(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              user.email,
              style: AppTextStyles.fontWeight500Size14.copyWith(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              user.phone,
              style: AppTextStyles.fontWeight500Size14.copyWith(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              user.jobTitle,
              style: AppTextStyles.fontWeight500Size14.copyWith(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            Divider(color: AppColors.greyDiveder, thickness: 1),
            SizedBox(height: 16.h),
            UserActions(),
          ],
        ),
      ),
    );
  }
}
