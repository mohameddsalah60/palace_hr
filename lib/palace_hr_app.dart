import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/networking/constants_database_path.dart';
import 'core/routing/app_router.dart';
import 'core/routing/app_routes.dart';
import 'core/services/shared_preferences_service.dart';
import 'core/utils/app_colors.dart';

class PalaceHr extends StatelessWidget {
  const PalaceHr({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        initialRoute:
            SharedPreferencesService.getString(
                  ConstantsDatabasePath.userDataLocalStorage,
                ).isEmpty
                ? AppRoutes.login
                : AppRoutes.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Palace HR',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          fontFamily: 'Inter',
          primaryColor: AppColors.mainBlue,
          scaffoldBackgroundColor: AppColors.backgroundScaffold,
        ),
      ),
    );
  }
}
