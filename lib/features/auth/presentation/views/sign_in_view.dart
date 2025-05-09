import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/core/di/getit_service_loacator.dart';
import 'package:palace_hr/features/auth/domin/repos/auth_repo.dart';
import 'package:palace_hr/features/auth/presentation/cubits/cubit/login_cubit.dart';
import 'package:palace_hr/features/auth/presentation/views/widgets/login_view_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(getIt<AuthRepo>()),
        child: SafeArea(child: LoginViewBody()),
      ),
    );
  }
}
