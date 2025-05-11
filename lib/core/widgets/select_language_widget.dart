import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../cubits/lang_change_cubit/lang_change_cubit.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class SelectLanguageWidget extends StatelessWidget {
  const SelectLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<LangChangeCubit>().changeLocale();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: AppColors.wheit,
          border: Border.all(
            width: 1,
            color: AppColors.black.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.language, color: AppColors.greyCheckBox, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              Intl.getCurrentLocale(),
              style: AppTextStyles.fontWeight400Size14,
            ),
          ],
        ),
      ),
    );
  }
}
