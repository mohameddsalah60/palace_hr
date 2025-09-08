import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';
import 'package:palace_hr/generated/l10n.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../home/domin/entites/attendance_entity.dart';
import '../../cubits/fetch_employe_attendance_cubit/fetch_employe_attendance_cubit.dart';

class AdminControlAttendancePopupMenu extends StatelessWidget {
  const AdminControlAttendancePopupMenu({super.key, required this.attendance});
  final AttendanceEntity attendance;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      onSelected: (value) {
        context.read<FetchEmployeAttendanceCubit>().controlAttendanceUser(
          type: value,
          attendance: attendance,
        );
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: "cancelCheckin",
              child: Text(
                S.of(context).cancelCheckin,
                style: AppTextStyles.fontWeight400Size14.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
            PopupMenuItem(
              value: "cancelCheckout",
              child: Text(
                S.of(context).cancelCheckout,
                style: AppTextStyles.fontWeight400Size14.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ],

      child: Icon(Icons.more_horiz, size: 24.r, color: AppColors.greyCheckBox),
    );
  }
}
