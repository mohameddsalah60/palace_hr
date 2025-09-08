import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';

import '../../../../../core/widgets/cutsom_modal_bottom_sheet.dart';
import '../../../../../generated/l10n.dart';
import 'employee_shift_changer_view.dart';

import 'penalties_user_detailes.dart';
import 'requests_user_detailes.dart';
import 'user_details_button.dart';

class UserActions extends StatelessWidget {
  const UserActions({super.key, required this.emailUser});
  final String emailUser;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserDetailsButton(
            iconData: Icons.timer_sharp,
            txt: s.editShift,
            color: AppColors.mainBlue,
            onTap: () {
              cutsomModalBottomSheet(
                context: context,
                child: EmployeeShiftChanger(emailUser: emailUser),
              );
            },
          ),
          SizedBox(width: 12.w),
          UserDetailsButton(
            iconData: Icons.check_circle_outlined,
            txt: s.request,
            color: AppColors.warning,
            onTap: () {
              cutsomModalBottomSheet(
                context: context,
                child: RequestsUserDetailes(emailUser: emailUser),
              );
            },
          ),
          SizedBox(width: 12.w),
          UserDetailsButton(
            iconData: Icons.safety_check_outlined,
            txt: s.penalties,
            color: AppColors.penaltyRedLight,
            onTap: () {
              cutsomModalBottomSheet(
                context: context,
                child: PenaltiesUserDetailes(emailUser: emailUser),
              );
            },
          ),
        ],
      ),
    );
  }
}
