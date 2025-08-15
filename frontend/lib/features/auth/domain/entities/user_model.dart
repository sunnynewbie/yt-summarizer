import 'package:frontend/core/utils/converters/bool_converter.dart';
import 'package:frontend/core/utils/converters/date_time_converter.dart';
import 'package:frontend/core/utils/converters/string_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
  converters: [StringConverter(), DateTimeConverter(), BooleanConverter()],
)
class UserModel {
  String id;
  String email;
  String name;
  String role;
  bool email_verified;
  DateTime trial_expires_at;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel({
    required this.id,
    required this.email,
    required this.name,
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
          role == other.role &&
          email_verified == other.email_verified &&
          trial_expires_at == other.trial_expires_at;

  @override
  int get hashCode =>
      Object.hash(id, email, name, role, email_verified, trial_expires_at);
}
