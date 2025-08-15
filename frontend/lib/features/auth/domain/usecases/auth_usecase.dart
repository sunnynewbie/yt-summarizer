import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/auth/data/repositories/auth_repository.dart';
import 'package:frontend/features/auth/domain/entities/login_model.dart';
import 'package:frontend/features/auth/domain/entities/user_model.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repo.dart';
import 'package:frontend/network/api_response.dart';

class LoginUsecase
    extends UseCase<ApiResponse<LoginModel?>?, Map<String, dynamic>> {
  AuthRepository repository = AuthRepoImpl();

  @override
  Future<ApiResponse<LoginModel?>?> call(Map<String, dynamic> params) {
    return repository.login(params);
  }
}

class RegisterUsecase extends UseCase<ApiResponse?, Map<String, dynamic>> {
  AuthRepository repository = AuthRepoImpl();

  @override
  Future<ApiResponse?> call(Map<String, dynamic> params) {
    return repository.register(params);
  }
}

class LogoutUsecase extends UseCase<ApiResponse?, Map<String, dynamic>> {
  AuthRepository repository = AuthRepoImpl();

  @override
  Future<ApiResponse?> call(Map<String, dynamic> params) {
    return repository.logout();
  }
}

class CheckTokenUsecase extends UseCase<ApiResponse?, NoParams> {
  AuthRepository repository = AuthRepoImpl();

  @override
  Future<ApiResponse?> call(NoParams params) {
    return repository.checkToken();
  }
}

class RefreshTokenUsecase extends UseCase<ApiResponse?, NoParams> {
  AuthRepository repository = AuthRepoImpl();

  @override
  Future<ApiResponse?> call(NoParams params) {
    return repository.refresh();
  }
}

class FetchUser extends UseCase<ApiResponse<UserModel?>?, NoParams> {
  AuthRepository repository = AuthRepoImpl();

  @override
  Future<ApiResponse<UserModel?>?> call(NoParams params) {
    return repository.fetchUser();
  }
}
