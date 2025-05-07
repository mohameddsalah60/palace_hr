import 'package:flutter/material.dart';

import '../utils/app_text_styles.dart';

void loadingState(BuildContext context, bool isFinished) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          contentPadding: const EdgeInsets.all(16),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Loading......',
                style: AppTextStyles.fontWeight500Size14.copyWith(
                  color: const Color(0xff000000),
                ),
              ),
              const CircularProgressIndicator(color: Colors.blue),
            ],
          ),
        ),
  );
}
