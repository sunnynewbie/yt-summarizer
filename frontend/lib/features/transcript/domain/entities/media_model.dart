// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/nullable_date_time_converter.dart';
import 'package:frontend/core/utils/converters/nullable_num_converter.dart';
import 'package:frontend/core/utils/converters/num_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_model.g.dart';

@JsonSerializable()
class MediaModel {
  @NumberConverter()
  num id;
  String source_url;
  String? title;
  String? type;
  String? audio_format;

  @NullableNumberConverter()
  num? duration_seconds;
  String status;
  String? failure_reason;
  String? audio_path;

  @NullableDateTimeConverter()
  DateTime? processed_at;

  @NullableDateTimeConverter()
  DateTime? createdAt;

  @NullableDateTimeConverter()
  DateTime? updatedAt;

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaModelToJson(this);

  MediaModel({
    required this.id,
    required this.source_url,
    this.title,
    this.type,
    this.audio_format,
    this.duration_seconds,
    required this.status,
    this.failure_reason,
    this.audio_path,
    this.processed_at,
    this.createdAt,
    this.updatedAt,
  });
}
