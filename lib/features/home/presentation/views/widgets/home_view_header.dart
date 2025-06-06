import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/helpers/get_user.dart';
import 'package:palace_hr/core/helpers/is_english_locale_funcation.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * .15,
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
      decoration: ShapeDecoration(
        color: AppColors.wheit,
        shadows: [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 30,
            color: Color(0x19000000),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment:
              isEnglishLocale()
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
          children: [
            Row(
              children: [
                getUser().faceIdUrl != null
                    ? CircleAvatar(
                      radius: 30.r,
                      backgroundImage: NetworkImage(getUser().faceIdUrl!),
                    )
                    : SizedBox.shrink(),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment:
                      isEnglishLocale()
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        getUser().name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppTextStyles.fontWeight500Size14.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Text(
                      getUser().jobTitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTextStyles.fontWeight500Size14.copyWith(
                        color: AppColors.grey,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
