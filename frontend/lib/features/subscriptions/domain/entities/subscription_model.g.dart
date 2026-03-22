// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) =>
    SubscriptionModel(
      id: json['id'] as String,
      user_id: json['user_id'] as String,
      plan_id: const NumberConverter().fromJson(json['plan_id']),
      start_date: const DateTimeConverter().fromJson(json['start_date']),
      end_date: const NullableDateTimeConverter().fromJson(json['end_date']),
      is_active: const BooleanConverter().fromJson(json['is_active']),
      plan: json['plan'] == null
          ? null
          : PlanModel.fromJson(json['plan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionModelToJson(SubscriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'plan_id': const NumberConverter().toJson(instance.plan_id),
      'start_date': const DateTimeConverter().toJson(instance.start_date),
      'end_date': const NullableDateTimeConverter().toJson(instance.end_date),
      'is_active': const BooleanConverter().toJson(instance.is_active),
      'plan': instance.plan?.toJson(),
    };
