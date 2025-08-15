import 'package:frontend/features/auth/domain/entities/login_model.dart';
import 'package:frontend/features/auth/domain/entities/user_model.dart';
import 'package:frontend/network/api_response.dart';

abstract class AuthRepository {
  Future<ApiResponse<LoginModel?>?> login(Map<String, dynamic> data);

  Future<ApiResponse?> register(Map<String, dynamic> data);

  Future<ApiResponse?> logout();

  Future<ApiResponse?> checkToken();

  Future<ApiResponse<LoginModel?>?> refresh();

  Future<ApiResponse<UserModel?>?> fetchUser();
}
