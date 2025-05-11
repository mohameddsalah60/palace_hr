import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:palace_hr/core/networking/constants_database_path.dart';
import 'package:palace_hr/core/services/shared_preferences_service.dart';

class LangChangeCubit extends Cubit<Locale> {
  LangChangeCubit()
    : super(
        Locale(
          SharedPreferencesService.getString(
                    ConstantsDatabasePath.langLocalStorageKey,
                  ) ==
                  ''
              ? Intl.getCurrentLocale()
              : SharedPreferencesService.getString(
                ConstantsDatabasePath.langLocalStorageKey,
              ),
        ),
      );

  void changeLocale() {
    if (Intl.getCurrentLocale() == 'en') {
      SharedPreferencesService.setData(
        key: ConstantsDatabasePath.langLocalStorageKey,
        value: 'ar',
      );

      emit(Locale('ar'));
    } else {
      SharedPreferencesService.setData(
        key: ConstantsDatabasePath.langLocalStorageKey,
        value: 'en',
      );
      emit(Locale('en'));
    }
  }
}
