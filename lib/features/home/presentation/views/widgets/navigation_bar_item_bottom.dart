import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

import '../../../domin/entites/bottom_navigation_bar_entity.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    super.key,
    required this.isSelected,
    required this.bottomNavigationBarItem,
  });

  final bool isSelected;
  final BottomNavigationBarEntity bottomNavigationBarItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isSelected ? AppColors.mainBlue : Colors.white,
            width: 3.w,
          ),
        ),
      ),
      child: Column(
        children: [
          Icon(
            bottomNavigationBarItem.icon,
            size: 22,
            color: isSelected ? AppColors.mainBlue : AppColors.greyCheckBox,
          ),
          SizedBox(width: 5.h),
          Text(
            bottomNavigationBarItem.name,
            style: AppTextStyles.fontWeight400Size14.copyWith(
              fontSize: 11.sp,
              color: isSelected ? AppColors.mainBlue : AppColors.greyCheckBox,
            ),
          ),
        ],
      ),
    );
  }
}
