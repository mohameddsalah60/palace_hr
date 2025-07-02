import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_images.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';
import 'package:animate_do/animate_do.dart';
import 'package:palace_hr/generated/l10n.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundScaffold,
      appBar: AppBar(
        backgroundColor: AppColors.wheit,
        elevation: 1,
        centerTitle: true,
        title: Text(lang.aboutApp, style: AppTextStyles.fontWeight700Size16),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              child: Center(
                child: Image.asset(
                  AppImages.appLogo,
                  width: 80.w,
                  height: 80.h,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            FadeInRight(
              child: Text(
                lang.aboutAppTitle,
                style: AppTextStyles.fontWeight700Size24.copyWith(
                  fontSize: 20.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10.h),
            FadeInRight(
              delay: Duration(milliseconds: 200),
              child: Text(
                lang.aboutAppDescription,
                style: AppTextStyles.fontWeight400Size14,
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 24.h),
            _buildFeatureItem(context, lang.feature1),
            _buildFeatureItem(context, lang.feature2),
            _buildFeatureItem(context, lang.feature3),
            _buildFeatureItem(context, lang.feature4),
            _buildFeatureItem(context, lang.feature5),
            SizedBox(height: 32.h),
            Divider(color: AppColors.greyBorder),
            SizedBox(height: 24.h),

            Center(
              child: Text(
                lang.appVersion_,
                style: AppTextStyles.fontWeight400Size12.copyWith(
                  color: AppColors.greyDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String text) {
    return FadeInLeft(
      duration: Duration(milliseconds: 400),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: AppColors.success,
              size: 22.r,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.fontWeight500Size14.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
