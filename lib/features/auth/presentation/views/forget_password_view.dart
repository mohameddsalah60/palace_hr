import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/core/di/getit_service_loacator.dart';
import 'package:palace_hr/core/widgets/custom_app_bar.dart';
import 'package:palace_hr/features/auth/domin/repos/auth_repo.dart';
import 'package:palace_hr/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';

import 'widgets/forget_password_body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Forget Password'),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ForgetPasswordCubit(getIt<AuthRepo>()),
          child: ForgetPasswordBody(),
        ),
      ),
    );
  }
}
