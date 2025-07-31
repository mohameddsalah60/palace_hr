import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class RequestCatogry extends StatelessWidget {
  const RequestCatogry({
    super.key,
    required this.text,
    required this.isSelected,
  });
  final String text;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.r),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 0.1),
        color: isSelected ? AppColors.mainBlue : AppColors.wheit,
      ),
      child: Text(
        text,
        style: AppTextStyles.fontWeight500Size14.copyWith(
          fontSize: 12.sp,
          color: isSelected ? AppColors.wheit : AppColors.black,
        ),
      ),
    );
  }
}
