import 'package:dio/dio.dart';

abstract class HomeRepository {
  Future<Response?> submitUrl({required Map<String, dynamic> data});
}
