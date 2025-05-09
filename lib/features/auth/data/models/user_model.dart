import 'package:json_annotation/json_annotation.dart';
import 'package:palace_hr/features/auth/domin/entites/user_entity.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.token,
    @JsonValue(3) super.countPermission,
    @JsonValue(22) super.countAnnualDays,
    super.faceIdUrl = '',
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      name: userEntity.name,
      email: userEntity.email,
      phone: userEntity.phone,
      token: userEntity.token,
      countPermission: userEntity.countPermission,
      countAnnualDays: userEntity.countAnnualDays,
      faceIdUrl: userEntity.faceIdUrl,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'token': token,
      'countPermission': countPermission,
      'countAnnualDays': countAnnualDays,
      'faceIdUrl': faceIdUrl,
    };
  }
}
