// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaModel _$MediaModelFromJson(Map<String, dynamic> json) => MediaModel(
  id: const NumberConverter().fromJson(json['id']),
  source_url: json['source_url'] as String,
  title: json['title'] as String?,
  type: json['type'] as String?,
  audio_format: json['audio_format'] as String?,
  duration_seconds: const NullableNumberConverter().fromJson(
    json['duration_seconds'],
  ),
  status: json['status'] as String,
  failure_reason: json['failure_reason'] as String?,
  audio_path: json['audio_path'] as String?,
  processed_at: const NullableDateTimeConverter().fromJson(
    json['processed_at'],
  ),
  createdAt: const NullableDateTimeConverter().fromJson(json['createdAt']),
  updatedAt: const NullableDateTimeConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$MediaModelToJson(MediaModel instance) =>
    <String, dynamic>{
      'id': const NumberConverter().toJson(instance.id),
      'source_url': instance.source_url,
      'title': instance.title,
      'type': instance.type,
      'audio_format': instance.audio_format,
      'duration_seconds': const NullableNumberConverter().toJson(
        instance.duration_seconds,
      ),
      'status': instance.status,
      'failure_reason': instance.failure_reason,
      'audio_path': instance.audio_path,
      'processed_at': const NullableDateTimeConverter().toJson(
        instance.processed_at,
      ),
      'createdAt': const NullableDateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const NullableDateTimeConverter().toJson(instance.updatedAt),
    };
