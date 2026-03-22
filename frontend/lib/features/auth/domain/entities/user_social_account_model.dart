// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'user_social_account_model.g.dart';

@JsonSerializable()
class UserSocialAccountModel {
  String id;
  String? user_id;
  String? provider;
  String provider_user_id;

  factory UserSocialAccountModel.fromJson(Map<String, dynamic> json) =>
      _$UserSocialAccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserSocialAccountModelToJson(this);

  UserSocialAccountModel({
    required this.id,
    this.user_id,
    this.provider,
    required this.provider_user_id,
  });
}
