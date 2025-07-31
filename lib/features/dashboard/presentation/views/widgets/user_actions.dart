import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';

import 'user_details_button.dart';

class UserActions extends StatelessWidget {
  const UserActions({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserDetailsButton(
            iconData: Icons.timer_sharp,
            txt: 'Edit Shift',
            color: AppColors.mainBlue,
          ),
          SizedBox(width: 12.w),
          UserDetailsButton(
            iconData: Icons.check_circle_outlined,
            txt: 'Requests',
            color: AppColors.warning,
          ),
          SizedBox(width: 12.w),
          UserDetailsButton(
            iconData: Icons.safety_check_outlined,
            txt: 'Penalties',
            color: AppColors.penaltyRedLight,
          ),
        ],
      ),
    );
  }
}
