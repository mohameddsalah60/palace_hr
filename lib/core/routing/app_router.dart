import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/auth/domin/entites/user_entity.dart';
import 'package:palace_hr/features/auth/presentation/views/forget_password_view.dart';
import 'package:palace_hr/features/auth/presentation/views/sign_in_view.dart';
import 'package:palace_hr/features/dashboard/presentation/views/all_employees_view.dart';
import 'package:palace_hr/features/dashboard/presentation/views/user_details_view.dart';
import 'package:palace_hr/features/home/presentation/views/home_view.dart';
import 'package:palace_hr/features/penalties/presentation/views/my_penalties_view.dart';
import 'package:palace_hr/features/requests/presentation/views/user_request_view.dart';
import 'package:palace_hr/features/settings/presentation/views/about_app.dart';
import 'package:palace_hr/features/settings/presentation/views/profile_user_setting.dart';
import 'package:palace_hr/features/settings/presentation/views/settings_view.dart';

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
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (context) => const SettingsView());
      case AppRoutes.aboutApp:
        return MaterialPageRoute(builder: (context) => const AboutAppPage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (context) => const UserProfilePage());

      case AppRoutes.allEmployees:
        return MaterialPageRoute(
          builder: (context) => const AllEmployeesView(),
        );
      case AppRoutes.uaerDetails:
        final user = settings.arguments as UserEntity;
        return MaterialPageRoute(
          builder: (context) => UserDetailsView(user: user),
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
