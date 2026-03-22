// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_query_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditLogQueryModel _$AuditLogQueryModelFromJson(Map<String, dynamic> json) =>
    AuditLogQueryModel(
      action: json['action'] as String?,
      feature_area: json['feature_area'] as String?,
      status_code: const NullableNumberConverter().fromJson(
        json['status_code'],
      ),
      outcome: json['outcome'] as String?,
      actor_user_id: json['actor_user_id'] as String?,
      from_date: const NullableDateTimeConverter().fromJson(json['from_date']),
      to_date: const NullableDateTimeConverter().fromJson(json['to_date']),
      page: const NullableNumberConverter().fromJson(json['page']),
      limit: const NullableNumberConverter().fromJson(json['limit']),
    );

Map<String, dynamic> _$AuditLogQueryModelToJson(
  AuditLogQueryModel instance,
) => <String, dynamic>{
  'action': ?instance.action,
  'feature_area': ?instance.feature_area,
  'status_code': ?const NullableNumberConverter().toJson(instance.status_code),
  'outcome': ?instance.outcome,
  'actor_user_id': ?instance.actor_user_id,
  'from_date': ?const NullableDateTimeConverter().toJson(instance.from_date),
  'to_date': ?const NullableDateTimeConverter().toJson(instance.to_date),
  'page': ?const NullableNumberConverter().toJson(instance.page),
  'limit': ?const NullableNumberConverter().toJson(instance.limit),
};
