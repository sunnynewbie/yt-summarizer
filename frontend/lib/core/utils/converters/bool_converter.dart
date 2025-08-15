import 'package:json_annotation/json_annotation.dart';

class BooleanConverter implements JsonConverter<bool, dynamic> {
  const BooleanConverter();

  @override
  bool fromJson(dynamic json) {
    if (json == null) return false;
    if (json is bool) return json;
    if (json is String) {
      return json.toLowerCase() == 'true';
    }
    if (json is num) {
      return json != 0;
    }
    return false; // or throw
  }

  @override
  dynamic toJson(bool object) {
    return object;
  }
}
