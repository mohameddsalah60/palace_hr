import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';

class CustomRequestTextField extends StatelessWidget {
  const CustomRequestTextField({
    super.key,
    required this.hint,
    this.controller,
    this.onSubmitted,
    this.onTap,
    this.maxLines,
  });
  final String hint;
  final TextEditingController? controller;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines ?? 1,
      onTap: onTap,
      controller: controller,
      onSubmitted: onSubmitted,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.wheitSecondary,
        hintText: hint,
        suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
        hintStyle: TextStyle(
          color: AppColors.textFieldSecondary,
          fontSize: 14.sp,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 10.r),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.greyBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.greyBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.greyBorder),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.greyBorder),
        ),
      ),
    );
  }
}
