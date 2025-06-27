import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../generated/l10n.dart';
import '../../request_cubit/request_cubit.dart';
import 'custom_request_text_field.dart';
import 'user_request_sumbit_button.dart';
import 'user_request_type_builder.dart';
import 'user_request_type_dropdown.dart';

class RequestDetails extends StatelessWidget {
  const RequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var requestCubit = context.read<RequestCubit>();
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.wheit,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).requestDetails,
            style: AppTextStyles.fontWeight600Size16.copyWith(
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),
          RequestTypeDropdown(),
          SizedBox(height: 12.h),
          CustomRequestTextField(
            hint: S.of(context).selectDate,
            controller: requestCubit.requestDayDateController,
            onTap: () => requestCubit.chooseDayDate(context),
          ),
          SizedBox(height: 12.h),
          RequestTypeBuilder(requestCubit: requestCubit),
          CustomRequestTextField(
            hint: S.of(context).uploadAttachment,
            controller: requestCubit.requestAttachmentController,
          ),
          SizedBox(height: 12.h),

          CustomTextFromField(
            hintText: S.of(context).additionalNotes,
            controller: requestCubit.requestNotesController,
            maxLines: 5,
          ),

          SizedBox(height: 24.h),
          UserRequestSumbitButton(),
        ],
      ),
    );
  }
}
