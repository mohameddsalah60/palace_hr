import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/core/helpers/extinctions.dart';

import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../cubits/forget_password_cubit/forget_password_cubit.dart';

class ForgetPasswordBlocListener extends StatelessWidget {
  const ForgetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          showDialog(
            context: context,
            builder: (context) => CustomCircularProgressIndicator(),
          );
        } else if (state is ForgetPasswordError) {
          context.pop();
          customSnackBar(context: context, message: state.error);
        } else if (state is ForgetPasswordSuccses) {
          context.pop();
          customSnackBar(
            context: context,
            message: 'Verification code sent to your email',
            color: Colors.green,
          );
          context.pop();
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
