import 'package:dio/src/response.dart';
import 'package:frontend/features/auth/data/datasources/auth_data_source.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl extends AuthRepository {
  AuthDataSource dataSource = AuthDataSouceImpl();

  @override
  Future<Response?> checkToken() {
    return dataSource.checkToken();
  }

  @override
  Future<Response?> fetchUser() {
    return dataSource.fetchUser();
  }

  @override
  Future<Response?> login(String username, String password) {
    return dataSource.login(username, password);
  }

  @override
  Future<Response?> logout() {
    return dataSource.logout();
  }

  @override
  Future<Response?> refresh() {
    return dataSource.refresh();
  }

  @override
  Future<Response?> register(String username, String password) {
    return dataSource.register(username, password);
  }
}
