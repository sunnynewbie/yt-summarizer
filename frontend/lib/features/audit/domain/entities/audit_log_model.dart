// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/date_time_converter.dart';
import 'package:frontend/core/utils/converters/nullable_num_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audit_log_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuditLogModel {
  String id;
  String? request_id;
  String? actor_user_id;
  String? actor_role;
  String action;
  String? feature_area;
  String? resource_type;
  String? resource_id;
  String http_method;

  @JsonKey(name: 'route_path')
  String? route_path;

  @NullableNumberConverter()
  num? status_code;

  String outcome;
  String? ip_address;
  String? user_agent;
  String? client_origin;

  @NullableNumberConverter()
  num? duration_ms;

  Map<String, dynamic> metadata;

  @DateTimeConverter()
  DateTime created_at;

  factory AuditLogModel.fromJson(Map<String, dynamic> json) =>
      _$AuditLogModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuditLogModelToJson(this);

  AuditLogModel({
    required this.id,
    this.request_id,
    this.actor_user_id,
    this.actor_role,
    required this.action,
    this.feature_area,
    this.resource_type,
    this.resource_id,
    required this.http_method,
    this.route_path,
    this.status_code,
    required this.outcome,
    this.ip_address,
    this.user_agent,
    this.client_origin,
    this.duration_ms,
    this.metadata = const {},
    required this.created_at,
  });
}
