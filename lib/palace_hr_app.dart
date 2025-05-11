import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/cubits/lang_change_cubit/lang_change_cubit.dart';

import 'core/networking/constants_database_path.dart';
import 'core/routing/app_router.dart';
import 'core/routing/app_routes.dart';
import 'core/services/shared_preferences_service.dart';
import 'core/utils/app_colors.dart';
import 'generated/l10n.dart';

class PalaceHr extends StatelessWidget {
  const PalaceHr({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) => LangChangeCubit(),
        child: BlocBuilder<LangChangeCubit, Locale>(
          builder: (context, state) {
            return MaterialApp(
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: state,
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
                fontFamily: 'Cairo',
                primaryColor: AppColors.mainBlue,
                scaffoldBackgroundColor: AppColors.backgroundScaffold,
              ),
            );
          },
        ),
      ),
    );
  }
}
