import 'package:json_annotation/json_annotation.dart';

class NullableStringConverter implements JsonConverter<String?, dynamic> {
  const NullableStringConverter();

  @override
  String? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    return json.toString();
  }

  @override
  dynamic toJson(String? object) {
    return object;
  }
}
