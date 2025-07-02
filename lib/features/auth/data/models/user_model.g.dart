// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  token: json['token'] as String,
  countPermission: (json['countPermission'] as num?)?.toInt() ?? 3,
  countAnnualDays: (json['countAnnualDays'] as num?)?.toInt() ?? 22,
  faceIdUrl: json['faceIdUrl'] as String? ?? '',
  jobTitle: json['jobTitle'] as String,
  offDay: json['offDay'] as String?,
  isAdmin: json['isAdmin'] as bool? ?? false,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'countPermission': instance.countPermission,
  'countAnnualDays': instance.countAnnualDays,
  'faceIdUrl': instance.faceIdUrl,
  'token': instance.token,
  'jobTitle': instance.jobTitle,
  'offDay': instance.offDay,
  'isAdmin': instance.isAdmin,
};
