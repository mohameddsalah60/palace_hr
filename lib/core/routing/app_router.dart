import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/auth/presentation/views/forget_password_view.dart';
import 'package:palace_hr/features/auth/presentation/views/sign_in_view.dart';
import 'package:palace_hr/features/home/presentation/views/home_view.dart';
import 'package:palace_hr/features/penalties/presentation/views/my_penalties_view.dart';
import 'package:palace_hr/features/requests/presentation/views/user_request_view.dart';

import '../../features/penalties/domin/repo/penalties_repo.dart';
import '../../features/penalties/presentation/cubits/cubit/fetch_pentalties_cubit.dart';
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
        return MaterialPageRoute(builder: (context) => const HomeView());
      case AppRoutes.penalteis:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create:
                    (context) => FetchPenaltiesCubit(getIt<PenaltiesRepo>()),
                child: const MyPenaltiesView(),
              ),
        );
      case AppRoutes.request:
        return MaterialPageRoute(builder: (context) => const UserRequestView());

      default:
        return MaterialPageRoute(
          builder:
              (context) =>
                  const Scaffold(body: Center(child: Text('404 Not Found'))),
        );
    }
  }
}
