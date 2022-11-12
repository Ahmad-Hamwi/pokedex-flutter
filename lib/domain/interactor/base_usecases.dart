abstract class UseCase {
  Future<void> execute();
}

abstract class RPUseCase<RETURN, PARAMS> {
  Future<RETURN> execute(PARAMS params);
}

abstract class ReturnUseCase<RETURN> {
  Future<RETURN> execute();
}

abstract class ParamsUseCase<PARAMS> {
  Future<void> execute(PARAMS params);
}
