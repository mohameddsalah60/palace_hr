import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/core/helpers/extinctions.dart';
import 'package:palace_hr/core/routing/app_routes.dart';

import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../cubits/cubit/login_cubit.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            builder: (context) => CustomCircularProgressIndicator(),
          );
        } else if (state is LoginError) {
          context.pop();
          customSnackBar(context: context, message: state.message);
        } else if (state is LoginSuccess) {
          context.pop();
          customSnackBar(
            context: context,
            message: 'Login successful',
            color: Colors.green,
          );
          context.pushReplacementNamed(AppRoutes.home);
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
