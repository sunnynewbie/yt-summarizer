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
      if (token?.token == null || token!.token!.isEmpty) {
        return null;
      }
      var data = {'refreshToken': token.token};

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
        fromJson: (data) {
          if (data is Map && data['data'] is Map) {
            return UserModel.fromJson(Map<String, dynamic>.from(data['data']));
          }
          return null;
        },
      );
    } on Exception {
      return null;
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
        fromJson: (data) {
          if (data is Map && data['data'] is Map) {
            return LoginModel.fromJson(Map<String, dynamic>.from(data['data']));
          }
          return null;
        },
      );
    } on Exception {
      return null;
    }
  }

  @override
  Future<ApiResponse?> logout() async {
    try {
      final authData = SharedPrefsHelper.getToken();
      if (authData?.token == null || authData!.token!.isEmpty) {
        return null;
      }
      var response = await ApiService().post(
        path: ApiPath.logout,
        data: {'refreshToken': authData.token},
      );
      if (response == null) {
        return null;
      }
      return ApiResponse.fromResponse(response);
    } on Exception {
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
        fromJson: (data) {
          if (data is Map) {
            return LoginModel.fromJson(Map<String, dynamic>.from(data));
          }
          return null;
        },
      );
    } on Exception {
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
      return ApiResponse.fromResponse(
        response,
        fromJson: (data) {
          if (data is Map) {
            final payload =
                data['data'] is Map<String, dynamic>
                    ? Map<String, dynamic>.from(data['data'])
                    : Map<String, dynamic>.from(data);
            return LoginModel.fromJson(payload);
          }
          return null;
        },
      );
    } on Exception {
      return null;
    }
  }
}
