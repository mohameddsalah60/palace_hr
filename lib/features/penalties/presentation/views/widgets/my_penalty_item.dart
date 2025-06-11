import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class PenaltyItem extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final String penaltyValue;

  const PenaltyItem({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.penaltyValue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.wheit,
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.fontWeight700Size16.copyWith(
                    color: AppColors.mainBlue,
                  ),
                ),
                Text(
                  date,
                  style: AppTextStyles.fontWeight400Size12.copyWith(
                    color: AppColors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // الوصف
            Text(
              description,
              style: AppTextStyles.fontWeight400Size14.copyWith(
                color: Colors.black87,
                height: 1.4.h,
              ),
            ),

            const SizedBox(height: 16),

            // قيمة الجزاء مع خلفية خفيفة وحواف دائرية
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.penaltyRedLight.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  penaltyValue,
                  style: AppTextStyles.fontWeight400Size12.copyWith(
                    color: AppColors.penaltyRed,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
