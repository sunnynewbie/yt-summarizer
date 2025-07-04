import 'package:dio/dio.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/home/data/repositories/home_repository.dart';

class SubmitUseCase extends UseCase<Response?, Map<String, dynamic>> {
  HomeRepository repository;

  SubmitUseCase(this.repository);

  @override
  Future<Response?> call(Map<String, dynamic> params) {
    return repository.submitUrl(data: params);
  }
}
