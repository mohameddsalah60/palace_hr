import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

import '../../../domin/entites/request_user_input_entity.dart';
import 'button_cancel_request.dart';

class RequestUserItem extends StatelessWidget {
  const RequestUserItem({super.key, required this.requestUserInputEntity});
  final RequestUserInputEntity requestUserInputEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.wheit,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                requestUserInputEntity.requestType,
                style: AppTextStyles.fontWeight700Size16,
              ),
              Text(
                "${requestUserInputEntity.requestCreatedAt!.year} ${requestUserInputEntity.monthName(requestUserInputEntity.requestCreatedAt!.month)} ${requestUserInputEntity.requestCreatedAt!.day}",

                style: AppTextStyles.fontWeight500Size14.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey[300]),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    requestUserInputEntity.requestType == 'Permissions' ||
                            requestUserInputEntity.requestType == 'Overtime'
                        ? Icons.timer_outlined
                        : Icons.calendar_today_sharp,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: 8.w),
                  requestUserInputEntity.requestType == 'Permissions' ||
                          requestUserInputEntity.requestType == 'Overtime'
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${requestUserInputEntity.formatTime(requestUserInputEntity.requestFromDate)} ~ ${requestUserInputEntity.formatTime(requestUserInputEntity.requestToDate)}",
                            style: AppTextStyles.fontWeight600Size16.copyWith(
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "${requestUserInputEntity.requestDateDay!.year} ${requestUserInputEntity.monthName(requestUserInputEntity.requestDateDay!.month)} ${requestUserInputEntity.requestDateDay!.day}",
                            style: AppTextStyles.fontWeight600Size16.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          requestUserInputEntity.requestNotes != null
                              ? Text(
                                requestUserInputEntity.requestNotes!,
                                style: AppTextStyles.fontWeight600Size16
                                    .copyWith(color: Colors.grey[600]),
                              )
                              : SizedBox.shrink(),
                        ],
                      )
                      : Text(
                        "${requestUserInputEntity.requestDateDay!.year} ${requestUserInputEntity.monthName(requestUserInputEntity.requestDateDay!.month)} ${requestUserInputEntity.requestDateDay!.day}",
                        style: AppTextStyles.fontWeight600Size16,
                      ),
                  SizedBox(width: 8.w),
                  requestUserInputEntity.requestType == 'Permissions' ||
                          requestUserInputEntity.requestType == 'Overtime'
                      ? SizedBox.shrink()
                      : Text(
                        '(1 DAY)',
                        style: AppTextStyles.fontWeight500Size14.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: requestUserInputEntity.requestStatusColor(
                    requestUserInputEntity.requestStatus!,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  requestUserInputEntity.requestStatus!,
                  style: AppTextStyles.fontWeight500Size14.copyWith(
                    color: AppColors.wheit,
                  ),
                ),
              ),
            ],
          ),

          // Cancel Button
          SizedBox(height: 16.h),
          requestUserInputEntity.requestStatus == 'pending' &&
                  requestUserInputEntity.requestType != 'Overtime'
              ? RequestButtonCancelRequest(request: requestUserInputEntity)
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
