import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/cubits/lang_change_cubit/lang_change_cubit.dart';
import 'package:palace_hr/core/helpers/is_english_locale_funcation.dart';

import '../../../../../core/utils/app_colors.dart';

void changeLocale(BuildContext context) {
  bool isEnglish = isEnglishLocale();
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    builder:
        (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Container(
                height: 16.h,
                width: 16.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isEnglish ? AppColors.mainBlue : AppColors.greyDark,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
              title: const Text('English'),
              trailing:
                  !isEnglish
                      ? SizedBox.shrink()
                      : Icon(
                        Icons.check,
                        color:
                            isEnglish ? AppColors.mainBlue : AppColors.greyDark,
                      ),
              onTap: () {
                context.read<LangChangeCubit>().changeLocale();
                Navigator.pop(context);
              },
            ),
            const Divider(),

            ListTile(
              leading: Container(
                height: 16.h,
                width: 16.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: !isEnglish ? AppColors.mainBlue : AppColors.greyDark,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
              title: const Text('العربية'),
              trailing:
                  isEnglish
                      ? SizedBox.shrink()
                      : Icon(
                        Icons.check,
                        color:
                            !isEnglish
                                ? AppColors.mainBlue
                                : AppColors.greyDark,
                      ),
              onTap: () {
                context.read<LangChangeCubit>().changeLocale();
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
  );
}
