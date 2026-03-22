import 'package:json_annotation/json_annotation.dart';

class NullableBooleanConverter implements JsonConverter<bool?, dynamic> {
  const NullableBooleanConverter();

  @override
  bool? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is bool) return json;
    if (json is String) {
      return json.toLowerCase() == 'true';
    }
    if (json is num) {
      return json != 0;
    }
    return null;
  }

  @override
  dynamic toJson(bool? object) {
    return object;
  }
}
