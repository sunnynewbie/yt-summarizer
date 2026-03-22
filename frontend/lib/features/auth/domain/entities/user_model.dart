// ignore_for_file: non_constant_identifier_names

import 'package:frontend/core/utils/converters/bool_converter.dart';
import 'package:frontend/core/utils/converters/date_time_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String id;
  String email;
  String? name;

  @JsonKey(name: 'password_hash')
  String? password_hash;

  String role;

  @BooleanConverter()
  bool email_verified;

  @DateTimeConverter()
  DateTime trial_expires_at;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.password_hash,
    required this.role,
    required this.email_verified,
    required this.trial_expires_at,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          name == other.name &&
          password_hash == other.password_hash &&
          role == other.role &&
          email_verified == other.email_verified &&
          trial_expires_at == other.trial_expires_at;

  @override
  int get hashCode => Object.hash(
    id,
    email,
    name,
    password_hash,
    role,
    email_verified,
    trial_expires_at,
  );
}
