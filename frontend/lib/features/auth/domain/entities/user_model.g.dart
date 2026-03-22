// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String?,
  password_hash: json['password_hash'] as String?,
  role: json['role'] as String,
  email_verified: const BooleanConverter().fromJson(json['email_verified']),
  trial_expires_at: const DateTimeConverter().fromJson(
    json['trial_expires_at'],
  ),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'password_hash': instance.password_hash,
  'role': instance.role,
  'email_verified': const BooleanConverter().toJson(instance.email_verified),
  'trial_expires_at': const DateTimeConverter().toJson(
    instance.trial_expires_at,
  ),
};
