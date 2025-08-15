import 'package:frontend/core/utils/converters/string_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(converters: [StringConverter()])
class LoginModel {
  String accessToken;
  String token;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  LoginModel({
    required this.accessToken,
    required this.token,
  });
}
