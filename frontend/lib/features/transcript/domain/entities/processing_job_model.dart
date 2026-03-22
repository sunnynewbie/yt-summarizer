// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/nullable_date_time_converter.dart';
import 'package:frontend/core/utils/converters/nullable_num_converter.dart';
import 'package:frontend/core/utils/converters/num_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'processing_job_model.g.dart';

@JsonSerializable()
class ProcessingJobModel {
  @NumberConverter()
  num id;

  @NullableNumberConverter()
  num? media_id;
  String job_type;
  String status;

  @NullableNumberConverter()
  num? attempts;
  String? last_error;

  @NullableDateTimeConverter()
  DateTime? started_at;

  @NullableDateTimeConverter()
  DateTime? finished_at;

  @NullableDateTimeConverter()
  DateTime? createdAt;

  @NullableDateTimeConverter()
  DateTime? updatedAt;

  factory ProcessingJobModel.fromJson(Map<String, dynamic> json) =>
      _$ProcessingJobModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessingJobModelToJson(this);

  ProcessingJobModel({
    required this.id,
    this.media_id,
    required this.job_type,
    required this.status,
    this.attempts,
    this.last_error,
    this.started_at,
    this.finished_at,
    this.createdAt,
    this.updatedAt,
  });
}
