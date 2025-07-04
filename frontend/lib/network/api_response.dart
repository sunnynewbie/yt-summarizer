import 'package:dio/dio.dart';

class ApiResponse<T> {
  String? message;
  T? data;
  bool status;

  ApiResponse({this.data, this.status = false, this.message});

  factory ApiResponse.fromResponse(
    Response response, {
    T? Function(dynamic data)? fromJson,
  }) {
    var apiResponse = ApiResponse<T>();
    if (response.statusCode == 200) {
      apiResponse.status = true;
      var data = response.data;
      apiResponse.data = data;
      if (data is Map) {
        if (data.containsKey('message') && data['message'] is String) {
          apiResponse.message = data['message'];
        }
        if (fromJson != null) {
          apiResponse.data = fromJson(data);
        }
      }
    }
    return apiResponse;
  }
}
