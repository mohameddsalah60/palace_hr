import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';
import 'package:palace_hr/core/widgets/network_circle_avatar_alt.dart';
import 'package:palace_hr/features/requests/domin/entites/request_user_input_entity.dart';

import 'requests_item_actions.dart';

class RequestsItem extends StatelessWidget {
  const RequestsItem({super.key, required this.requestUserInputEntity});
  final RequestUserInputEntity requestUserInputEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.wheit,
        border: Border.all(color: AppColors.greyBorder),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              NetworkCircleAvatarAlt(
                imageUrl: requestUserInputEntity.requestUserImage,
              ),
              SizedBox(width: 14.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    requestUserInputEntity.requestCreatedBy,
                    style: AppTextStyles.fontWeight700Size16,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.event_note, size: 16.r, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        requestUserInputEntity.requestType,
                        style: AppTextStyles.fontWeight400Size14,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 16.r,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        requestUserInputEntity.requestStatus!,
                        style: AppTextStyles.fontWeight400Size14.copyWith(
                          color:
                              requestUserInputEntity.requestStatus == 'approved'
                                  ? Colors.green[700]
                                  : requestUserInputEntity.requestStatus ==
                                      'rejected'
                                  ? Colors.red
                                  : Colors.orangeAccent[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16.r,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "${requestUserInputEntity.requestDateDay!.year} ${requestUserInputEntity.monthName(requestUserInputEntity.requestDateDay!.month)} ${requestUserInputEntity.requestDateDay!.day}",
                        style: AppTextStyles.fontWeight400Size14,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20.h),
          requestUserInputEntity.requestStatus != "pending"
              ? SizedBox.shrink()
              : RequestsItemActions(
                requestUserInputEntity: requestUserInputEntity,
              ),
        ],
      ),
    );
  }
}
