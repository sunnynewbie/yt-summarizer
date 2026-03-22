import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  String accessToken;

  @JsonKey(readValue: _readTokenValue)
  String? token;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  LoginModel({
    required this.accessToken,
    this.token,
  });

  static Object? _readTokenValue(Map json, String key) {
    return json[key] ?? json['refreshToken'];
  }
}
