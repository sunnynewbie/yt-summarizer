// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/nullable_date_time_converter.dart';
import 'package:frontend/core/utils/converters/nullable_num_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audit_log_query_model.g.dart';

@JsonSerializable(includeIfNull: false)
class AuditLogQueryModel {
  String? action;
  String? feature_area;

  @NullableNumberConverter()
  num? status_code;

  String? outcome;
  String? actor_user_id;

  @JsonKey(name: 'from_date')
  @NullableDateTimeConverter()
  DateTime? from_date;

  @JsonKey(name: 'to_date')
  @NullableDateTimeConverter()
  DateTime? to_date;

  @NullableNumberConverter()
  num? page;

  @NullableNumberConverter()
  num? limit;

  factory AuditLogQueryModel.fromJson(Map<String, dynamic> json) =>
      _$AuditLogQueryModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuditLogQueryModelToJson(this);

  AuditLogQueryModel({
    this.action,
    this.feature_area,
    this.status_code,
    this.outcome,
    this.actor_user_id,
    this.from_date,
    this.to_date,
    this.page,
    this.limit,
  });
}
