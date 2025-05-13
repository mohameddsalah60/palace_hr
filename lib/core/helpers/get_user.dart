import 'dart:convert';

import 'package:palace_hr/core/services/shared_preferences_service.dart';

import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/domin/entites/user_entity.dart';
import '../networking/constants_database_path.dart';

UserEntity getUser() {
  var jsonData = SharedPreferencesService.getString(
    ConstantsDatabasePath.userDataLocalStorage,
  );
  var userEntity = UserModel.fromJson(jsonDecode(jsonData));
  return userEntity;
}
