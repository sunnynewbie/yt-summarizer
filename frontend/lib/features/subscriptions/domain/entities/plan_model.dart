import 'package:frontend/core/utils/converters/bool_converter.dart';
import 'package:frontend/core/utils/converters/num_converter.dart';
import 'package:frontend/core/utils/converters/string_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plan_model.g.dart';

@JsonSerializable(
  converters: [StringConverter(), NumberConverter(), BooleanConverter()],
)
class PlanModel {
  String id;
  String plan_name;
  num video_limit;
  num minute_limit;
  num price;
  String plan_content;
  bool is_active;

  factory PlanModel.fromJson(Map<String, dynamic> json) =>
      _$PlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlanModelToJson(this);

  PlanModel({
    required this.id,
    required this.plan_name,
    required this.video_limit,
    required this.minute_limit,
    required this.price,
    required this.plan_content,
    required this.is_active,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          plan_name == other.plan_name &&
          video_limit == other.video_limit &&
          minute_limit == other.minute_limit &&
          price == other.price &&
          is_active == other.is_active;

  @override
  int get hashCode =>
      Object.hash(id, plan_name, video_limit, minute_limit, price, is_active);
}
