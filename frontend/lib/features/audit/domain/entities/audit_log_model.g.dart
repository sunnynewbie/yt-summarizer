// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditLogModel _$AuditLogModelFromJson(
  Map<String, dynamic> json,
) => AuditLogModel(
  id: json['id'] as String,
  request_id: json['request_id'] as String?,
  actor_user_id: json['actor_user_id'] as String?,
  actor_role: json['actor_role'] as String?,
  action: json['action'] as String,
  feature_area: json['feature_area'] as String?,
  resource_type: json['resource_type'] as String?,
  resource_id: json['resource_id'] as String?,
  http_method: json['http_method'] as String,
  route_path: json['route_path'] as String?,
  status_code: const NullableNumberConverter().fromJson(json['status_code']),
  outcome: json['outcome'] as String,
  ip_address: json['ip_address'] as String?,
  user_agent: json['user_agent'] as String?,
  client_origin: json['client_origin'] as String?,
  duration_ms: const NullableNumberConverter().fromJson(json['duration_ms']),
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  created_at: const DateTimeConverter().fromJson(json['created_at']),
);

Map<String, dynamic> _$AuditLogModelToJson(
  AuditLogModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'request_id': instance.request_id,
  'actor_user_id': instance.actor_user_id,
  'actor_role': instance.actor_role,
  'action': instance.action,
  'feature_area': instance.feature_area,
  'resource_type': instance.resource_type,
  'resource_id': instance.resource_id,
  'http_method': instance.http_method,
  'route_path': instance.route_path,
  'status_code': const NullableNumberConverter().toJson(instance.status_code),
  'outcome': instance.outcome,
  'ip_address': instance.ip_address,
  'user_agent': instance.user_agent,
  'client_origin': instance.client_origin,
  'duration_ms': const NullableNumberConverter().toJson(instance.duration_ms),
  'metadata': instance.metadata,
  'created_at': const DateTimeConverter().toJson(instance.created_at),
};
