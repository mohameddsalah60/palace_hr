import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  // Dio dio = DioFactory.getDio();
  // getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // // login
  // getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  // getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
}
