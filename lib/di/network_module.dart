import 'package:dio/dio.dart';
import 'package:pokedex/infrastructure/remote/client/api_client.dart';
import 'package:pokedex/infrastructure/remote/client/dio_api_client.dart';
import 'package:pokedex/infrastructure/remote/client/logger_interceptor.dart';
import 'package:pokedex/infrastructure/remote/exception/exception_factory.dart';
import 'package:pokedex/infrastructure/remote/service/pokemon_api_service.dart';
import 'package:pokedex/infrastructure/repository/pokemon/datasource/pokemon_remote_datasource.dart';

import 'container.dart';

void registerNetwork() {
  sl.registerFactory<IRemoteExceptionFactory>(
      () => ResponseCodeExceptionFactory());

  _registerInterceptors();

  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        sendTimeout: 15 * 1000,
        receiveTimeout: 15 * 1000,
      ),
    )..interceptors.addAll([
        sl<LoggerInterceptor>(),
      ]),
  );

  sl.registerLazySingleton<IApiClient>(
    () => DioApiClient(sl<Dio>(), sl<IRemoteExceptionFactory>()),
  );

  _registerServices();
  _registerRemoteDataSources();
}

void _registerInterceptors() {
  sl.registerLazySingleton<LoggerInterceptor>(
    () => LoggerInterceptor(),
  );
}

void _registerServices() {
  sl.registerLazySingleton<IPokemonService>(
    () => PokemonApiService(sl<IApiClient>()),
  );
}

void _registerRemoteDataSources() {
  sl.registerLazySingleton<IPokemonRemoteDatasource>(
      () => PokemonRemoteDatasourceImpl(sl<IPokemonService>()));
}
