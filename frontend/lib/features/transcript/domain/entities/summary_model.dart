// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/nullable_date_time_converter.dart';
import 'package:frontend/core/utils/converters/nullable_num_converter.dart';
import 'package:frontend/core/utils/converters/num_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_model.g.dart';

@JsonSerializable()
class SummaryModel {
  @NumberConverter()
  num id;

  @NumberConverter()
  num media_id;
  String summary;
  String? style;
  String? prompt_used;
  String? model_used;

  @NullableNumberConverter()
  num? token_count;

  @NullableNumberConverter()
  num? temperature;

  @NullableNumberConverter()
  num? top_p;

  @NullableDateTimeConverter()
  DateTime? createdAt;

  @NullableDateTimeConverter()
  DateTime? updatedAt;

  factory SummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryModelToJson(this);

  SummaryModel({
    required this.id,
    required this.media_id,
    required this.summary,
    this.style,
    this.prompt_used,
    this.model_used,
    this.token_count,
    this.temperature,
    this.top_p,
    this.createdAt,
    this.updatedAt,
  });
}
