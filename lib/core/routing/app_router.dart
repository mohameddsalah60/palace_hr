import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoutes.login:
      //   return MaterialPageRoute(builder: (context) => const LoginView());
      default:
        return MaterialPageRoute(
          builder:
              (context) =>
                  const Scaffold(body: Center(child: Text('404 Not Found'))),
        );
    }
  }
}
