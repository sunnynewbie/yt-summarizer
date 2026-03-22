// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
  id: json['id'] as String,
  user_id: json['user_id'] as String,
  video_url: json['video_url'] as String,
  video_title: json['video_title'] as String?,
  video_duration_seconds: const NullableNumberConverter().fromJson(
    json['video_duration_seconds'],
  ),
  status: json['status'] as String,
  progress: json['progress'] as String?,
  transcript: json['transcript'] as String?,
  summary: json['summary'] as String?,
  transcript_url: json['transcript_url'] as String?,
  summary_url: json['summary_url'] as String?,
  error_message: json['error_message'] as String?,
  createdAt: const NullableDateTimeConverter().fromJson(json['createdAt']),
  updatedAt: const NullableDateTimeConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.user_id,
  'video_url': instance.video_url,
  'video_title': instance.video_title,
  'video_duration_seconds': const NullableNumberConverter().toJson(
    instance.video_duration_seconds,
  ),
  'status': instance.status,
  'progress': instance.progress,
  'transcript': instance.transcript,
  'summary': instance.summary,
  'transcript_url': instance.transcript_url,
  'summary_url': instance.summary_url,
  'error_message': instance.error_message,
  'createdAt': const NullableDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const NullableDateTimeConverter().toJson(instance.updatedAt),
};
