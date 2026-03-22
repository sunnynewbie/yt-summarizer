// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/nullable_date_time_converter.dart';
import 'package:frontend/core/utils/converters/nullable_num_converter.dart';
import 'package:frontend/core/utils/converters/num_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transcript_model.g.dart';

@JsonSerializable()
class TranscriptModel {
  @NumberConverter()
  num id;

  @NumberConverter()
  num media_id;
  String? language;
  String? format;
  String content;

  @NullableNumberConverter()
  num? confidence;

  @NullableDateTimeConverter()
  DateTime? createdAt;

  @NullableDateTimeConverter()
  DateTime? updatedAt;

  factory TranscriptModel.fromJson(Map<String, dynamic> json) =>
      _$TranscriptModelFromJson(json);

  Map<String, dynamic> toJson() => _$TranscriptModelToJson(this);

  TranscriptModel({
    required this.id,
    required this.media_id,
    this.language,
    this.format,
    required this.content,
    this.confidence,
    this.createdAt,
    this.updatedAt,
  });
}
