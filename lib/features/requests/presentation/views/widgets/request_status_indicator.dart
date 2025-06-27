import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/helpers/is_english_locale_funcation.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';
import 'package:palace_hr/features/requests/presentation/fetch_requests_cubit/fetch_requests_cubit.dart';

class RequestStatusIndicator extends StatefulWidget {
  const RequestStatusIndicator({super.key});

  @override
  State<RequestStatusIndicator> createState() => _RequestStatusIndicatorState();
}

class _RequestStatusIndicatorState extends State<RequestStatusIndicator> {
  List<String> statusEn = ['pending', 'approved', 'rejected'];
  List<String> statusAr = ['قيد الانتظار', 'مقبول', 'مرفوض'];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.wheit,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                context.read<FetchRequestsCubit>().currunt = index;
                context.read<FetchRequestsCubit>().fetchRequestsBySort(
                  status: isEnglishLocale() ? statusEn[index] : statusAr[index],
                );
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.r),
              decoration: BoxDecoration(
                color:
                    context.read<FetchRequestsCubit>().currunt == index
                        ? AppColors.mainBlue
                        : AppColors.wheit,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                isEnglishLocale() ? statusEn[index] : statusAr[index],
                style: AppTextStyles.fontWeight600Size16.copyWith(
                  color:
                      context.read<FetchRequestsCubit>().currunt == index
                          ? AppColors.wheit
                          : AppColors.grey,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
