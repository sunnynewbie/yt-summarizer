import 'package:dio/src/response.dart';
import 'package:frontend/features/auth/data/datasources/auth_data_source.dart';
import 'package:frontend/features/auth/domain/entities/login_model.dart';
import 'package:frontend/features/auth/domain/entities/user_model.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repo.dart';
import 'package:frontend/network/api_response.dart';

class AuthRepoImpl extends AuthRepository {
  AuthDataSource dataSource = AuthDataSouceImpl();

  @override
  Future<ApiResponse?> checkToken() {
    return dataSource.checkToken();
  }

  @override
  Future<ApiResponse<UserModel?>?> fetchUser() {
    return dataSource.fetchUser();
  }

  @override
  Future<ApiResponse<LoginModel?>?> login(Map<String, dynamic> data) {
    return dataSource.login(data);
  }

  @override
  Future<ApiResponse?> logout() {
    return dataSource.logout();
  }

  @override
  Future<ApiResponse<LoginModel?>?> refresh() {
    return dataSource.refresh();
  }

  @override
  Future<ApiResponse?> register(Map<String,dynamic> data) {
    return dataSource.register(data);
  }
}
