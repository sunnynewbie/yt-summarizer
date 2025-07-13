import 'package:dio/dio.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/auth/data/repositories/auth_repository.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repo.dart';

class LoginUsecase extends UseCase<Response?, Map<String, dynamic>> {
  AuthRepository repository = AuthRepoImpl();

  @override
  Future<Response?> call(Map<String, dynamic> params) {
    return repository.login(params['username'], params['password']);
  }
}

class RegisterUsecase extends UseCase<Response?, Map<String, dynamic>> {
  AuthRepository repository = AuthRepoImpl();

  @override
  Future<Response?> call(Map<String, dynamic> params) {
    return repository.register(params['username'], params['password']);
  }
}

class LogoutUsecase extends UseCase<Response?, Map<String, dynamic>> {
  AuthRepository repository = AuthRepoImpl();

  @override
  Future<Response?> call(Map<String, dynamic> params) {
    return repository.logout();
  }
}

class CheckTokenUsecase extends UseCase<Response?, Map<String, dynamic>> {
  AuthRepository repository = AuthRepoImpl();

  @override
  Future<Response?> call(Map<String, dynamic> params) {
    return repository.checkToken();
  }
}

class RefreshTokenUsecase extends UseCase<Response?, Map<String, dynamic>> {
  AuthRepository repository = AuthRepoImpl();

  @override
  Future<Response?> call(Map<String, dynamic> params) {
    return repository.refresh();
  }
}
