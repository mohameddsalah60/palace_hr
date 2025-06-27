import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class UserRequestIndicator extends StatefulWidget {
  const UserRequestIndicator({super.key});

  @override
  State<UserRequestIndicator> createState() => _UserRequestIndicatorState();
}

class _UserRequestIndicatorState extends State<UserRequestIndicator> {
  int currunt = 0;
  List<String> status = ['Permission', 'Annoul Leave'];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.wheit,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(2, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                currunt = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.r),
              decoration: BoxDecoration(
                color: currunt == index ? AppColors.mainBlue : AppColors.wheit,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                status[index],
                style: AppTextStyles.fontWeight600Size16.copyWith(
                  color: currunt == index ? AppColors.wheit : AppColors.grey,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
