// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/num_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_sub_model.g.dart';

@JsonSerializable()
class CreateSubModel {
  @NumberConverter()
  num plan_id;

  factory CreateSubModel.fromJson(Map<String, dynamic> json) =>
      _$CreateSubModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSubModelToJson(this);

  Map<String, dynamic> toMap() => toJson();

  CreateSubModel({required this.plan_id});
}
