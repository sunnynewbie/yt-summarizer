// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_usage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUsageModel _$UserUsageModelFromJson(Map<String, dynamic> json) =>
    UserUsageModel(
      id: const NumberConverter().fromJson(json['id']),
      user_id: json['user_id'] as String,
      month_year: json['month_year'] as String,
      videos_used: const NumberConverter().fromJson(json['videos_used']),
      minutes_used: const NumberConverter().fromJson(json['minutes_used']),
      last_updated: const DateTimeConverter().fromJson(json['last_updated']),
    );

Map<String, dynamic> _$UserUsageModelToJson(UserUsageModel instance) =>
    <String, dynamic>{
      'id': const NumberConverter().toJson(instance.id),
      'user_id': instance.user_id,
      'month_year': instance.month_year,
      'videos_used': const NumberConverter().toJson(instance.videos_used),
      'minutes_used': const NumberConverter().toJson(instance.minutes_used),
      'last_updated': const DateTimeConverter().toJson(instance.last_updated),
    };
