// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogModel _$LogModelFromJson(Map<String, dynamic> json) => LogModel(
  id: const NumberConverter().fromJson(json['id']),
  media_id: const NullableNumberConverter().fromJson(json['media_id']),
  level: json['level'] as String?,
  message: json['message'] as String?,
  meta: json['meta'] as Map<String, dynamic>?,
  timestamp: const NullableDateTimeConverter().fromJson(json['timestamp']),
);

Map<String, dynamic> _$LogModelToJson(LogModel instance) => <String, dynamic>{
  'id': const NumberConverter().toJson(instance.id),
  'media_id': const NullableNumberConverter().toJson(instance.media_id),
  'level': instance.level,
  'message': instance.message,
  'meta': instance.meta,
  'timestamp': const NullableDateTimeConverter().toJson(instance.timestamp),
};
