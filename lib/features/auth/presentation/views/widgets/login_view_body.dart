import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_button.dart';

import '../../cubits/cubit/login_cubit.dart';
import 'login_bloc_listener.dart';
import 'login_body_header.dart';
import 'forget_password.dart';
import 'terms_and_conditions_text.dart';
import 'text_fields_login.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoginBodyHeader(),
            SizedBox(height: 36.h),
            TextFieldsLogin(),
            SizedBox(height: 16.h),
            ForgetPassword(),
            SizedBox(height: 24.h),
            CustomButton(
              onPressed: () {
                if (context
                    .read<LoginCubit>()
                    .formKey
                    .currentState!
                    .validate()) {
                  context.read<LoginCubit>().signInWithEmailAndPassword();
                }
              },
              text: 'Login',
            ),
            SizedBox(height: 24.h),
            TermsAndConditionsText(),
            SizedBox(height: 24.h),
            LoginBlocListener(),
          ],
        ),
      ),
    );
  }
}
