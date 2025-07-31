import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? hintText;

  const CustomSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.wheit,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.greyBorder),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTextStyles.fontWeight600Size16,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.fontWeight400Size12.copyWith(
            color: AppColors.grey,
          ),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: AppColors.greyDark),
        ),
      ),
    );
  }
}
