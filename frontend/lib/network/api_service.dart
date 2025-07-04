import 'package:dio/dio.dart';
import 'package:frontend/network/api_path.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  Dio dio = Dio(
    BaseOptions(contentType: Headers.jsonContentType, baseUrl: ApiPath.baseUrl),
  )..interceptors.add(PrettyDioLogger());

  Future<Response?> get({
    required String path,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      var response = await dio.get(path, queryParameters: queryParameter);
      return response;
    } on DioException catch (e) {
    } catch (e) {}
    return null;
  }

  Future<Response?> post({
    required path,
    Map<String, dynamic>? queryparam,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.post(
        path,
        queryParameters: queryparam,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
