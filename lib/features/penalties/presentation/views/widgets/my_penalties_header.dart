import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class MyPenaltiesHeader extends StatelessWidget {
  const MyPenaltiesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      titleAlignment: ListTileTitleAlignment.center,
      title: Text('My Penalties', style: AppTextStyles.fontWeight700Size16),
      trailing: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.wheit,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: GestureDetector(child: Icon(FontAwesomeIcons.calendar)),
      ),
    );
  }
}
