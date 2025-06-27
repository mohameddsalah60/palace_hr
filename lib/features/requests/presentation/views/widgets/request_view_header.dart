import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palace_hr/core/helpers/extinctions.dart';
import 'package:palace_hr/core/routing/app_routes.dart';
import 'package:palace_hr/generated/l10n.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class RequestViewHeader extends StatelessWidget {
  const RequestViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      titleAlignment: ListTileTitleAlignment.center,
      title: Text(
        S.of(context).myrequest,
        style: AppTextStyles.fontWeight700Size16,
      ),
      trailing: GestureDetector(
        onTap: () {
          context.pushNamed(AppRoutes.request);
        },
        child: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: AppColors.wheit,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Icon(FontAwesomeIcons.plus),
        ),
      ),
    );
  }
}
