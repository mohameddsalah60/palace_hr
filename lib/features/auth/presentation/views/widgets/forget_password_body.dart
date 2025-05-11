import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:palace_hr/core/widgets/custom_button.dart';
import 'package:palace_hr/core/widgets/custom_text_field.dart';
import 'package:palace_hr/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:palace_hr/generated/l10n.dart';
import '../../../../../core/utils/app_text_styles.dart';
import 'forget_password_bloc_listener.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: context.read<ForgetPasswordCubit>().formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            Text(
              s.forgetPasswordInstruction,
              textAlign: TextAlign.center,
              style: AppTextStyles.fontWeight400Size14.copyWith(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 24.h),
            CustomTextFromField(
              hintText: s.email,
              controller: context.read<ForgetPasswordCubit>().emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return s.emailRequired;
                } else if (!RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                ).hasMatch(value)) {
                  return s.emailInvalid;
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            CustomButton(
              onPressed: () {
                if (context
                    .read<ForgetPasswordCubit>()
                    .formKey
                    .currentState!
                    .validate()) {
                  context.read<ForgetPasswordCubit>().sendPasswordResetEmail();
                }
              },
              text: s.send,
            ),
            SizedBox(height: 20.h),
            const ForgetPasswordBlocListener(),
          ],
        ),
      ),
    );
  }
}
