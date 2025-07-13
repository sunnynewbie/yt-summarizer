import 'package:dio/dio.dart';
import 'package:frontend/network/api_path.dart';
import 'package:frontend/network/api_service.dart';

abstract class AuthDataSource {
  Future<Response?> login(String username, String password);

  Future<Response?> register(String username, String password);

  Future<Response?> logout();

  Future<Response?> checkToken();

  Future<Response?> refresh();

  Future<Response?> fetchUser();
}

class AuthDataSouceImpl extends AuthDataSource {
  @override
  Future<Response?> checkToken() async {
    try {
      var data = {'token': 'token'};

      var response = await ApiService().post(
        path: ApiPath.refreshToken,
        data: data,
      );
      return response;
    } on Exception catch (e) {
      return null;
    }
  }

  @override
  Future<Response?> fetchUser() {
    // TODO: implement fetchUser
    throw UnimplementedError();
  }

  @override
  Future<Response?> login(String username, String password) async {
    try {
      var data = {'username': username, 'password': password};
      var response = await ApiService().post(
        path: ApiPath.authLogin,
        data: data,
      );
      return response;
    } on Exception catch (e) {
      return null;
    }
  }

  @override
  Future<Response?> logout() async {
    try {
      var response = await ApiService().get(path: ApiPath.logout);
      return response;
    } on Exception catch (e) {
      return null;
    }
  }

  @override
  Future<Response?> refresh() async {
    try {
      var response = await ApiService().get(path: ApiPath.refreshToken);
      return response;
    } on Exception catch (e) {
      return null;
    }
  }

  @override
  Future<Response?> register(String username, String password) async {
    try {
      var data = {'username': username, 'password': password};
      var response = await ApiService().post(
        path: ApiPath.authRegister,
        data: data,
      );
      return response;
    } on Exception catch (e) {
      return null;
    }
  }
}
