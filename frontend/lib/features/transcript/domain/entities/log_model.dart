// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/nullable_date_time_converter.dart';
import 'package:frontend/core/utils/converters/nullable_num_converter.dart';
import 'package:frontend/core/utils/converters/num_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'log_model.g.dart';

@JsonSerializable()
class LogModel {
  @NumberConverter()
  num id;

  @NullableNumberConverter()
  num? media_id;
  String? level;
  String? message;
  Map<String, dynamic>? meta;

  @NullableDateTimeConverter()
  DateTime? timestamp;

  factory LogModel.fromJson(Map<String, dynamic> json) =>
      _$LogModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogModelToJson(this);

  LogModel({
    required this.id,
    this.media_id,
    this.level,
    this.message,
    this.meta,
    this.timestamp,
  });
}
