import 'package:dio/dio.dart';
import 'package:frontend/core/utils/toast_util.dart';

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
    var data = response.data;
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 304 ||
        response.statusCode == 307) {
      apiResponse.status = true;
      if (data is Map) {
        if (data.containsKey('message') && data['message'] is String) {
          apiResponse.message = data['message'];
        }
        if (fromJson != null) {
          apiResponse.data = fromJson(data);
        }
      } else {
        apiResponse.data = data;
      }
    } else {
      if (data is Map) {
        if (data.containsKey('error') && data['error'] is String) {
          apiResponse.message = data['error'];
          if (apiResponse.message != null && apiResponse.message!.isNotEmpty) {
            ToastUtil().showFailedToast(apiResponse.message ?? '');
          }
        }
      } else {
        apiResponse.data = data;
      }
    }

    return apiResponse;
  }
}
