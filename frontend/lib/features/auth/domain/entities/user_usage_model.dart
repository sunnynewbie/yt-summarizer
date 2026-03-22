// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/date_time_converter.dart';
import 'package:frontend/core/utils/converters/num_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_usage_model.g.dart';

@JsonSerializable()
class UserUsageModel {
  @NumberConverter()
  num id;
  String user_id;
  String month_year;

  @NumberConverter()
  num videos_used;

  @NumberConverter()
  num minutes_used;

  @DateTimeConverter()
  DateTime last_updated;

  factory UserUsageModel.fromJson(Map<String, dynamic> json) =>
      _$UserUsageModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserUsageModelToJson(this);

  UserUsageModel({
    required this.id,
    required this.user_id,
    required this.month_year,
    required this.videos_used,
    required this.minutes_used,
    required this.last_updated,
  });
}
