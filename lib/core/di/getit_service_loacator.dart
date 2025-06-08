import 'package:get_it/get_it.dart';
import 'package:palace_hr/core/networking/firebase_auth_service.dart';
import 'package:palace_hr/core/networking/firestore_service.dart';
import 'package:palace_hr/core/networking/geo_location_service.dart';
import 'package:palace_hr/core/networking/location_service.dart';
import 'package:palace_hr/core/networking/storage_service.dart';
import 'package:palace_hr/core/networking/supabase_storage.dart';
import 'package:palace_hr/features/auth/data/repos/auth_repo_impl.dart';
import 'package:palace_hr/features/auth/domin/repos/auth_repo.dart';
import 'package:palace_hr/features/home/data/repos/home_repo_impl.dart';
import 'package:palace_hr/features/home/data/repos/user_repo_impl.dart';
import 'package:palace_hr/features/home/domin/repos/face_recognition_repo.dart';
import 'package:palace_hr/features/home/domin/repos/face_user_repo.dart';
import 'package:palace_hr/features/home/domin/repos/home_repo.dart';

import '../../features/home/data/repos/face_recognition_repo_impl.dart';
import '../networking/auth_service.dart';
import '../networking/database_service.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton<StorageService>(SupabaseStorage());
  getIt.registerSingleton<DatabaseService>(FirestoreService());
  getIt.registerSingleton<AuthService>(FirebaseAuthService());
  getIt.registerSingleton<LocationService>(GeoLocationService());

  // // Auth
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      authService: getIt<AuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
  getIt.registerSingleton<FaceRecognitionRepo>(FaceRecognitionRepoImpl());
  getIt.registerSingleton<FaceUserRepo>(
    UserRepoImpl(
      storageService: getIt<StorageService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
  getIt.registerSingleton<UserRepoImpl>(
    UserRepoImpl(
      storageService: getIt<StorageService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(
      locationService: getIt<LocationService>(),
      storageService: getIt<StorageService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
}
