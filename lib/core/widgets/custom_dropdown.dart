import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.items,
    required this.tital,
    this.onChanged,
  });
  final List<DropdownMenuItem<String>> items;
  final String tital;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: items,
      onChanged: onChanged,
      icon: Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.wheitSecondary,
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
      ),
      hint: Text(
        tital,
        style: AppTextStyles.fontWeight400Size14.copyWith(
          color: AppColors.textFieldSecondary,
        ),
      ),

      style: TextStyle(color: AppColors.black, fontSize: 14.sp),
    );
  }
}
