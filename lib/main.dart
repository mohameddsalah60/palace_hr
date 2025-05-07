import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/observer_bloc.dart';
import 'core/services/shared_preferences_service.dart';
import 'palace_hr_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();

  Bloc.observer = MyBlocObserver();
  runApp(const PalaceHr());
}
