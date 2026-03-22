// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/date_time_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_model.g.dart';

@JsonSerializable()
class RefreshTokenModel {
  String id;
  String user_id;
  String token;

  @DateTimeConverter()
  DateTime expires_at;

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenModelToJson(this);

  RefreshTokenModel({
    required this.id,
    required this.user_id,
    required this.token,
    required this.expires_at,
  });
}
