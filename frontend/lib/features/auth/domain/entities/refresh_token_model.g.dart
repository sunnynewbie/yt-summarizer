// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenModel _$RefreshTokenModelFromJson(Map<String, dynamic> json) =>
    RefreshTokenModel(
      id: json['id'] as String,
      user_id: json['user_id'] as String,
      token: json['token'] as String,
      expires_at: const DateTimeConverter().fromJson(json['expires_at']),
    );

Map<String, dynamic> _$RefreshTokenModelToJson(RefreshTokenModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'token': instance.token,
      'expires_at': const DateTimeConverter().toJson(instance.expires_at),
    };
