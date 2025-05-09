import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../cubits/cubit/login_cubit.dart';
import 'password_validations.dart';

class TextFieldsLogin extends StatefulWidget {
  const TextFieldsLogin({super.key});

  @override
  State<TextFieldsLogin> createState() => _TextFieldsLoginState();
}

class _TextFieldsLoginState extends State<TextFieldsLogin> {
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<LoginCubit>().passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(
          passwordController.text,
        );
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          CustomTextFromField(
            controller: context.read<LoginCubit>().emailController,
            validator: context.read<LoginCubit>().validatorEmail,
            hintText: 'Email',
          ),
          SizedBox(height: 16.h),
          PasswordFieldLogin(passwordController: passwordController),
          SizedBox(height: 16.h),
          PasswordValidations(
            hasLowerCase: hasLowercase,
            hasUpperCase: hasUppercase,
            hasSpecialCharacters: hasSpecialCharacters,
            hasNumber: hasNumber,
            hasMinLength: hasMinLength,
          ),
        ],
      ),
    );
  }
}

class PasswordFieldLogin extends StatelessWidget {
  const PasswordFieldLogin({super.key, required this.passwordController});

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFromField(
      obscureText: context.watch<LoginCubit>().isObscure,
      suffixIcon: IconButton(
        onPressed: () {
          context.read<LoginCubit>().togglePasswordVisibility();
        },
        icon: Icon(
          context.read<LoginCubit>().isObscure
              ? Icons.visibility
              : Icons.visibility_off,
        ),
      ),
      controller: passwordController,
      validator: context.read<LoginCubit>().validatorPassword,

      hintText: 'Password',
    );
  }
}
