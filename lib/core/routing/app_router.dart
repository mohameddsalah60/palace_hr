import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/auth/presentation/views/forget_password_view.dart';
import 'package:palace_hr/features/auth/presentation/views/sign_in_view.dart';
import 'package:palace_hr/features/home/presentation/views/home_view.dart';

import '../../features/home/domin/repos/home_repo.dart';
import '../../features/home/presentation/cubits/cubit/user_schedule_cubit.dart';
import '../di/getit_service_loacator.dart';
import 'app_routes.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const SignInView());
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordView(),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create:
                    (context) =>
                        UserScheduleCubit(getIt<HomeRepo>())
                          ..loadUserSchedules(),
                child: const HomeView(),
              ),
        );

      default:
        return MaterialPageRoute(
          builder:
              (context) =>
                  const Scaffold(body: Center(child: Text('404 Not Found'))),
        );
    }
  }
}
