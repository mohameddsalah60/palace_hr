import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_face_api/flutter_face_api.dart';
import 'package:palace_hr/core/networking/supabase_storage.dart';

import 'core/di/getit_service_loacator.dart';
import 'core/services/observer_bloc.dart';
import 'core/services/shared_preferences_service.dart';
import 'firebase_options.dart';
import 'palace_hr_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Future.wait([
    SupabaseStorage.initSupabase(),
    SharedPreferencesService.init(),
    FaceSDK.instance.initialize(),
    setup(),
  ]);

  Bloc.observer = MyBlocObserver();
  runApp(const PalaceHr());
}
