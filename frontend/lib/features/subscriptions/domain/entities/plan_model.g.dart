// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanModel _$PlanModelFromJson(Map<String, dynamic> json) => PlanModel(
  id: const NumberConverter().fromJson(json['id']),
  plan_name: json['plan_name'] as String,
  video_limit: const NumberConverter().fromJson(json['video_limit']),
  minute_limit: const NumberConverter().fromJson(json['minute_limit']),
  price: const NumberConverter().fromJson(json['price']),
  plan_content: json['plan_content'] as String?,
  is_active: const BooleanConverter().fromJson(json['is_active']),
);

Map<String, dynamic> _$PlanModelToJson(PlanModel instance) => <String, dynamic>{
  'id': const NumberConverter().toJson(instance.id),
  'plan_name': instance.plan_name,
  'video_limit': const NumberConverter().toJson(instance.video_limit),
  'minute_limit': const NumberConverter().toJson(instance.minute_limit),
  'price': const NumberConverter().toJson(instance.price),
  'plan_content': instance.plan_content,
  'is_active': const BooleanConverter().toJson(instance.is_active),
};
