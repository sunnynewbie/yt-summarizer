// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_social_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSocialAccountModel _$UserSocialAccountModelFromJson(
  Map<String, dynamic> json,
) => UserSocialAccountModel(
  id: json['id'] as String,
  user_id: json['user_id'] as String?,
  provider: json['provider'] as String?,
  provider_user_id: json['provider_user_id'] as String,
);

Map<String, dynamic> _$UserSocialAccountModelToJson(
  UserSocialAccountModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.user_id,
  'provider': instance.provider,
  'provider_user_id': instance.provider_user_id,
};
