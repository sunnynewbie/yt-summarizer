// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/bool_converter.dart';
import 'package:frontend/core/utils/converters/date_time_converter.dart';
import 'package:frontend/core/utils/converters/nullable_date_time_converter.dart';
import 'package:frontend/core/utils/converters/num_converter.dart';
import 'package:frontend/features/subscriptions/domain/entities/plan_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SubscriptionModel {
  String id;
  String user_id;

  @NumberConverter()
  num plan_id;

  @DateTimeConverter()
  DateTime start_date;

  @NullableDateTimeConverter()
  DateTime? end_date;

  @BooleanConverter()
  bool is_active;
  PlanModel? plan;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);

  SubscriptionModel({
    required this.id,
    required this.user_id,
    required this.plan_id,
    required this.start_date,
    this.end_date,
    required this.is_active,
    this.plan,
  });
}
