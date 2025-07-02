import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/core/helpers/extinctions.dart';

import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../cubits/logout_cubit/logout_cubit.dart';

class SettingsBlocListener extends StatelessWidget {
  const SettingsBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      child: SliverToBoxAdapter(child: SizedBox.shrink()),
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.pushReplacementNamed(AppRoutes.login);
        } else if (state is LogoutFailure) {
          customSnackBar(context: context, message: state.message);
        }
      },
    );
  }
}
