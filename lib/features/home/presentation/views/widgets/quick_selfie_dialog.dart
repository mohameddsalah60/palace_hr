import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/di/getit_service_loacator.dart';
import '../../../../../core/helpers/get_user.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../domin/repos/home_repo.dart';
import '../../cubits/firset_selfie_cubit/firset_selfie_cubit.dart';
import 'firset_selfie_bloc_listener.dart';

void quickSelfieDialog(BuildContext context, {bool? isLoading}) {
  final faceIdUrl = getUser().faceIdUrl;

  if (faceIdUrl == null || faceIdUrl.isEmpty) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final s = S.of(context);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BlocProvider(
            create: (context) => FirsetSelfieCubit(getIt<HomeRepo>()),
            child: AlertDialog(
              backgroundColor: AppColors.wheit,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 24.h,
              ),
              content: QuickSelfieBody(s: s),
            ),
          );
        },
      );
    });
  }
}

class QuickSelfieBody extends StatelessWidget {
  const QuickSelfieBody({super.key, required this.s});

  final S s;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.celebration, color: Colors.green, size: 48.r),
        SizedBox(height: 16.h),
        Text(
          s.loginSuccessTitle,
          style: AppTextStyles.fontWeight600Size16.copyWith(
            color: AppColors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          s.selfieRequestBody,
          style: AppTextStyles.fontWeight400Size14.copyWith(
            color: AppColors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32.h),
        CustomButton(
          isLoading: context.watch<FirsetSelfieCubit>().isLoading,
          onPressed: () {
            context.read<FirsetSelfieCubit>().uploudFile();
          },
          text: s.startButton,
        ),
        FirsetSelfieBlocListener(child: SizedBox.shrink()),
      ],
    );
  }
}
