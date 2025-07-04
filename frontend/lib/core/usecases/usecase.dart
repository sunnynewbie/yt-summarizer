abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}

class NoParams {
  const NoParams();
}
