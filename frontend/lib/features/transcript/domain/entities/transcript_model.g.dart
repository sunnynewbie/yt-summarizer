// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranscriptModel _$TranscriptModelFromJson(Map<String, dynamic> json) =>
    TranscriptModel(
      id: const NumberConverter().fromJson(json['id']),
      media_id: const NumberConverter().fromJson(json['media_id']),
      language: json['language'] as String?,
      format: json['format'] as String?,
      content: json['content'] as String,
      confidence: const NullableNumberConverter().fromJson(json['confidence']),
      createdAt: const NullableDateTimeConverter().fromJson(json['createdAt']),
      updatedAt: const NullableDateTimeConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$TranscriptModelToJson(TranscriptModel instance) =>
    <String, dynamic>{
      'id': const NumberConverter().toJson(instance.id),
      'media_id': const NumberConverter().toJson(instance.media_id),
      'language': instance.language,
      'format': instance.format,
      'content': instance.content,
      'confidence': const NullableNumberConverter().toJson(instance.confidence),
      'createdAt': const NullableDateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const NullableDateTimeConverter().toJson(instance.updatedAt),
    };
