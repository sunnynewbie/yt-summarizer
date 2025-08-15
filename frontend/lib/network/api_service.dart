import 'package:dio/dio.dart';
import 'package:frontend/core/utils/pref_util.dart';
import 'package:frontend/network/api_path.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum ApiStatus {
  success,
  error,
  initial,
  unAuthenticated,
  userActionLoading,
  loading;

  bool get isError => this == ApiStatus.error;

  bool get isSuccess => this == ApiStatus.success;

  bool get isLoading => this == ApiStatus.loading;

  bool get isInitial => this == ApiStatus.initial;

  bool get isUnAuthenticated => this == ApiStatus.unAuthenticated;

  bool get isUserActionLoading => this == ApiStatus.userActionLoading;
}

class ApiService {
  Dio dio =
      Dio(
          BaseOptions(
            contentType: Headers.jsonContentType,
            baseUrl: ApiPath.baseUrl,
            headers: {'ngrok-skip-browser-warning': true},
          ),
        )
        ..interceptors.add(
          PrettyDioLogger(compact: true, responseBody: false, error: true),
        );

  Future<Response?> get({
    required String path,
    Map<String, dynamic>? queryParameter,
    bool setToken = true,
  }) async {
    try {
      if (setToken) {
        var token = SharedPrefsHelper.getToken();
        if (token != null) {
          dio.options.headers['Authorization'] = 'Bearer ${token!.accessToken}';
        }
      }
      var response = await dio.get(path, queryParameters: queryParameter);
      return response;
    } on DioException catch (e) {
      return e.response;
    } catch (e) {}
    return null;
  }

  Future<Response?> post({
    required path,
    Map<String, dynamic>? queryparam,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    bool setToken = true,
  }) async {
    try {
      if (setToken) {
        var token = SharedPrefsHelper.getToken();
        if (token != null) {
          dio.options.headers['Authorization'] = 'Bearer ${token!.accessToken}';
        }
        dio.options.headers.addAll(headers ?? {});
      }
      var response = await dio.post(
        path,
        queryParameters: queryparam,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Response?> put({
    required path,
    Map<String, dynamic>? queryparam,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    bool setToken = true,
  }) async {
    try {
      if (setToken) {
        var token = SharedPrefsHelper.getToken();
        if (token != null) {
          dio.options.headers['Authorization'] = 'Bearer ${token!.accessToken}';
        }
        dio.options.headers.addAll(headers ?? {});
      }
      var response = await dio.put(
        path,
        queryParameters: queryparam,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    } catch (e) {}
  }

  Future<Response?> delete({
    required path,
    Map<String, dynamic>? queryparam,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.delete(
        path,
        queryParameters: queryparam,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class DioErrorHandler {
  static Map<String, dynamic> handleError(dynamic error) {
    if (error is DioException) {
      // Handle DioException
      return _handleDioError(error);
    } else {
      // Handle other types of errors
      return {
        'status': false,
        'error': error.toString(),
        'message': 'An unexpected error occurred',
      };
    }
  }

  static Map<String, dynamic> _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return {
          'status': false,
          'error': error.type.toString(),
          'message': 'Request to API server was cancelled',
        };
      case DioExceptionType.connectionTimeout:
        return {
          'status': false,
          'error': error.type.toString(),
          'message': 'Connection timeout with API server',
        };
      case DioExceptionType.receiveTimeout:
        return {
          'status': false,
          'error': error.type.toString(),
          'message': 'Receive timeout in connection with API server',
        };
      case DioExceptionType.badResponse:
        if (error.response != null &&
            error.response!.data is Map<String, dynamic>) {
          final errorResponse = error.response!.data as Map<String, dynamic>;
          if (errorResponse.containsKey('status') &&
              errorResponse.containsKey('error') &&
              errorResponse.containsKey('message')) {
            return {
              'status': errorResponse['status'],
              'error': errorResponse['error'],
              'message': errorResponse['message'],
            };
          }
        }
        return {
          'status': false,
          'error': error.type.toString(),
          'message':
              'Received invalid status code: ${error.response?.statusCode}',
        };
      case DioExceptionType.sendTimeout:
        return {
          'status': false,
          'error': error.type.toString(),
          'message': 'Send timeout in connection with API server',
        };
      case DioExceptionType.unknown:
        return {
          'status': false,
          'error': error.type.toString(),
          'message':
              'Connection to API server failed due to internet connection',
        };
      default:
        return {
          'status': false,
          'error': error.type.toString(),
          'message': 'Something went wrong',
        };
    }
  }
}
