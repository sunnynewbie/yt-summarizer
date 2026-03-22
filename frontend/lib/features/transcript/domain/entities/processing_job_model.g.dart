// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processing_job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessingJobModel _$ProcessingJobModelFromJson(
  Map<String, dynamic> json,
) => ProcessingJobModel(
  id: const NumberConverter().fromJson(json['id']),
  media_id: const NullableNumberConverter().fromJson(json['media_id']),
  job_type: json['job_type'] as String,
  status: json['status'] as String,
  attempts: const NullableNumberConverter().fromJson(json['attempts']),
  last_error: json['last_error'] as String?,
  started_at: const NullableDateTimeConverter().fromJson(json['started_at']),
  finished_at: const NullableDateTimeConverter().fromJson(json['finished_at']),
  createdAt: const NullableDateTimeConverter().fromJson(json['createdAt']),
  updatedAt: const NullableDateTimeConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$ProcessingJobModelToJson(
  ProcessingJobModel instance,
) => <String, dynamic>{
  'id': const NumberConverter().toJson(instance.id),
  'media_id': const NullableNumberConverter().toJson(instance.media_id),
  'job_type': instance.job_type,
  'status': instance.status,
  'attempts': const NullableNumberConverter().toJson(instance.attempts),
  'last_error': instance.last_error,
  'started_at': const NullableDateTimeConverter().toJson(instance.started_at),
  'finished_at': const NullableDateTimeConverter().toJson(instance.finished_at),
  'createdAt': const NullableDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const NullableDateTimeConverter().toJson(instance.updatedAt),
};
