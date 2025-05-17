import 'package:flutter/material.dart';
import 'package:palace_hr/core/widgets/custom_circular_progress_indicator.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
    this.textColor,
    this.isLoading = false,
  });
  final void Function()? onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.mainBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child:
            isLoading == true
                ? CustomCircularProgressIndicator()
                : Text(
                  text,
                  style: AppTextStyles.fontWeight600Size16.copyWith(
                    color: textColor ?? Colors.white,
                  ),
                ),
      ),
    );
  }
}
