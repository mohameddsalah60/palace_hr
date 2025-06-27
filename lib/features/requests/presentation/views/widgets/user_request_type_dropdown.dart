import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

import '../../../../../generated/l10n.dart';
import '../../request_cubit/request_cubit.dart';

class RequestTypeDropdown extends StatelessWidget {
  const RequestTypeDropdown({super.key});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: [
        DropdownMenuItem(
          value: 'Annoul Leave',
          child: Text(S.of(context).annualLeave),
        ),
        DropdownMenuItem(
          value: 'Permissions',
          child: Text(S.of(context).permissions),
        ),
        DropdownMenuItem(
          value: 'Sick Leave',
          child: Text(S.of(context).sickLeave),
        ),
      ],
      onChanged: (value) {
        context.read<RequestCubit>().setRequestType(value ?? '');
      },
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
        S.of(context).selectRequestType,
        style: AppTextStyles.fontWeight400Size14.copyWith(
          color: AppColors.textFieldSecondary,
        ),
      ),

      style: TextStyle(color: AppColors.black, fontSize: 14.sp),
    );
  }
}
