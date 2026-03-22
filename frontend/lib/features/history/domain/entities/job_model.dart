// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/nullable_date_time_converter.dart';
import 'package:frontend/core/utils/converters/nullable_num_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_model.g.dart';

@JsonSerializable()
class JobModel {
  String id;
  String user_id;
  String video_url;
  String? video_title;

  @NullableNumberConverter()
  num? video_duration_seconds;
  String status;
  String? progress;
  String? transcript;
  String? summary;
  String? transcript_url;
  String? summary_url;
  String? error_message;

  @NullableDateTimeConverter()
  DateTime? createdAt;

  @NullableDateTimeConverter()
  DateTime? updatedAt;

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobModelToJson(this);

  JobModel({
    required this.id,
    required this.user_id,
    required this.video_url,
    this.video_title,
    this.video_duration_seconds,
    required this.status,
    this.progress,
    this.transcript,
    this.summary,
    this.transcript_url,
    this.summary_url,
    this.error_message,
    this.createdAt,
    this.updatedAt,
  });
}
