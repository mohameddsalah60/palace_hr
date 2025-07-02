import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';
import 'package:palace_hr/core/widgets/custom_app_bar.dart';

import '../../../../core/helpers/get_user.dart';
import '../../../../core/widgets/network_circle_avatar_alt.dart';
import '../../../../generated/l10n.dart';
import 'widgets/delete_account_button.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getUser();
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundScaffold,
      appBar: buildAppBar(context, title: lang.userProfile),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(child: NetworkCircleAvatarAlt(imageUrl: user.faceIdUrl)),
            SizedBox(height: 20.h),
            FadeInRight(
              child: Text(user.name, style: AppTextStyles.fontWeight700Size24),
            ),
            SizedBox(height: 6.h),
            FadeInRight(
              delay: Duration(milliseconds: 200),
              child: Text(
                user.jobTitle,
                style: AppTextStyles.fontWeight500Size14.copyWith(
                  color: AppColors.greyDark,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            _buildInfoTile(lang.email, user.email, Icons.email),
            _buildInfoTile(lang.phoneLabel, user.phone, Icons.phone),
            SizedBox(height: 24.h),
            DeleteAccountButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return FadeInLeft(
      duration: Duration(milliseconds: 400),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.wheit,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.mainBlue, size: 22.r),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.fontWeight400Size12.copyWith(
                      color: AppColors.greyDark,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(value, style: AppTextStyles.fontWeight600Size16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
