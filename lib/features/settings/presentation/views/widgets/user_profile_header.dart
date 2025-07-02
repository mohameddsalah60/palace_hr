import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/helpers/extinctions.dart';
import 'package:palace_hr/core/helpers/get_user.dart';
import 'package:palace_hr/core/routing/app_routes.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/network_circle_avatar_alt.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.profile);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: AppColors.wheit,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              NetworkCircleAvatarAlt(
                imageUrl: getUser().faceIdUrl,
                radius: 30.r,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getUser().name,
                    style: AppTextStyles.fontWeight700Size16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    getUser().email,
                    style: AppTextStyles.fontWeight400Size14,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
