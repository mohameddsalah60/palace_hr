import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

import '../../../../../generated/l10n.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return FadeInUp(
      delay: Duration(milliseconds: 300),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.penaltyRedLight.withValues(alpha: .2),
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Text(
              lang.deleteAccountPrompt,
              style: AppTextStyles.fontWeight600Size16,
            ),
            SizedBox(height: 12.h),
            ElevatedButton.icon(
              onPressed: () {
                _showDeleteAccountConfirmation(context);
              },
              icon: Icon(Icons.delete_outline, color: AppColors.error),
              label: Text(
                lang.deleteAccount,
                style: AppTextStyles.fontWeight600Size16.copyWith(
                  color: AppColors.error,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0,
                side: BorderSide(color: AppColors.error),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountConfirmation(BuildContext context) {
    final lang = S.of(context);
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(lang.confirmDeleteTitle),
            content: Text(lang.confirmDeleteContent),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  lang.cancel,
                  style: AppTextStyles.fontWeight400Size14.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  lang.delete,
                  style: AppTextStyles.fontWeight400Size14.copyWith(
                    color: AppColors.penaltyRed,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
