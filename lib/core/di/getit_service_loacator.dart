import 'package:get_it/get_it.dart';
import 'package:palace_hr/core/networking/firebase_auth_service.dart';
import 'package:palace_hr/core/networking/firestore_service.dart';
import 'package:palace_hr/features/auth/data/repos/auth_repo_impl.dart';
import 'package:palace_hr/features/auth/domin/repos/auth_repo.dart';

import '../networking/auth_service.dart';
import '../networking/database_service.dart';

final getIt = GetIt.instance;

void setup() {
  // Dio dio = DioFactory.getDio();
  // // Services
  getIt.registerSingleton<DatabaseService>(FirestoreService());
  getIt.registerSingleton<AuthService>(FirebaseAuthService());

  // // Auth
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      authService: getIt<AuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
}
