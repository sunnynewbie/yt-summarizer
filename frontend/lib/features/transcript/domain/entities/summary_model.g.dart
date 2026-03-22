// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryModel _$SummaryModelFromJson(Map<String, dynamic> json) => SummaryModel(
  id: const NumberConverter().fromJson(json['id']),
  media_id: const NumberConverter().fromJson(json['media_id']),
  summary: json['summary'] as String,
  style: json['style'] as String?,
  prompt_used: json['prompt_used'] as String?,
  model_used: json['model_used'] as String?,
  token_count: const NullableNumberConverter().fromJson(json['token_count']),
  temperature: const NullableNumberConverter().fromJson(json['temperature']),
  top_p: const NullableNumberConverter().fromJson(json['top_p']),
  createdAt: const NullableDateTimeConverter().fromJson(json['createdAt']),
  updatedAt: const NullableDateTimeConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$SummaryModelToJson(
  SummaryModel instance,
) => <String, dynamic>{
  'id': const NumberConverter().toJson(instance.id),
  'media_id': const NumberConverter().toJson(instance.media_id),
  'summary': instance.summary,
  'style': instance.style,
  'prompt_used': instance.prompt_used,
  'model_used': instance.model_used,
  'token_count': const NullableNumberConverter().toJson(instance.token_count),
  'temperature': const NullableNumberConverter().toJson(instance.temperature),
  'top_p': const NullableNumberConverter().toJson(instance.top_p),
  'createdAt': const NullableDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const NullableDateTimeConverter().toJson(instance.updatedAt),
};
