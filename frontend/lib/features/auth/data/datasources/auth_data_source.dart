import 'package:frontend/core/utils/pref_util.dart';
import 'package:frontend/features/auth/domain/entities/login_model.dart';
import 'package:frontend/features/auth/domain/entities/user_model.dart';
import 'package:frontend/network/api_path.dart';
import 'package:frontend/network/api_response.dart';
import 'package:frontend/network/api_service.dart';

abstract class AuthDataSource {
  Future<ApiResponse<LoginModel?>?> login(Map<String, dynamic> data);

  Future<ApiResponse?> register(Map<String, dynamic> data);

  Future<ApiResponse?> logout();

  Future<ApiResponse?> checkToken();

  Future<ApiResponse<LoginModel?>?> refresh();

  Future<ApiResponse<UserModel?>?> fetchUser();
}

class AuthDataSouceImpl extends AuthDataSource {
  @override
  Future<ApiResponse?> checkToken() async {
    try {
      var token = SharedPrefsHelper.getToken();
      var data = {'token': token!.accessToken};

      var response = await ApiService().post(
        path: ApiPath.refreshToken,
        data: data,
      );
      if (response == null) {
        return null;
      }
      return ApiResponse.fromResponse(response);
    } on Exception catch (e) {
      return null;
    }
  }

  @override
  Future<ApiResponse<UserModel?>?> fetchUser() async {
    try {
      var response = await ApiService().get(path: ApiPath.me);
      if (response == null) {
        return null;
      }
      return ApiResponse.fromResponse(
        response,
        fromJson: (data) =>
            data['data'] is Map ? UserModel.fromJson(data['data']) : null,
      );
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<ApiResponse<LoginModel?>?> login(Map<String, dynamic> data) async {
    try {
      var response = await ApiService().post(
        path: ApiPath.authLogin,
        data: data,
      );
      if (response == null) {
        return null;
      }
      return ApiResponse.fromResponse(
        response,
        fromJson: (data) =>
            data['data'] is Map ? LoginModel.fromJson(data['data']) : null,
      );
    } on Exception catch (e) {
      return null;
    }
  }

  @override
  Future<ApiResponse?> logout() async {
    try {
      var response = await ApiService().get(path: ApiPath.logout);
      if (response == null) {
        return null;
      }
      return ApiResponse.fromResponse(response);
    } on Exception catch (e) {
      return null;
    }
  }

  @override
  Future<ApiResponse<LoginModel?>?> refresh() async {
    try {
      var authData = SharedPrefsHelper.getToken();
      var data = {'refreshToken': authData?.token};
      var response = await ApiService().post(
        path: ApiPath.refreshToken,
        data: data,
      );
      if (response == null) {
        return null;
      }
      return ApiResponse.fromResponse(
        response,
        fromJson: (data) =>
            data['data'] is Map ? LoginModel.fromJson(data['data']) : null,
      );
    } on Exception catch (e) {
      return null;
    }
  }

  @override
  Future<ApiResponse?> register(Map<String, dynamic> data) async {
    try {
      var response = await ApiService().post(
        path: ApiPath.authRegister,
        data: data,
      );
      if (response == null) {
        return null;
      }
      return ApiResponse.fromResponse(response);
    } on Exception catch (e) {
      return null;
    }
  }
}
