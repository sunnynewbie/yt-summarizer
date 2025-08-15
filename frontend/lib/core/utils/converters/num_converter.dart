import 'package:json_annotation/json_annotation.dart';

class NumberConverter implements JsonConverter<num, dynamic> {
  const NumberConverter();

  @override
  num fromJson(dynamic json) {
    if (json == null) return 0;
    if (json is num) return json;
    if (json is String) {
      final number = num.tryParse(json);
      if (number != null) return number;
    }
    return 0; // or throw exception based on your use case
  }

  @override
  dynamic toJson(num object) {
    return object;
  }
}