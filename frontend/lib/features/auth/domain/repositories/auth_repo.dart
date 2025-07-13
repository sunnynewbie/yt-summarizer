import 'package:dio/dio.dart';

abstract class AuthRepository {
  Future<Response?> login(String username, String password);

  Future<Response?> register(String username, String password);

  Future<Response?> logout();

  Future<Response?> checkToken();

  Future<Response?> refresh();

  Future<Response?> fetchUser();
}
