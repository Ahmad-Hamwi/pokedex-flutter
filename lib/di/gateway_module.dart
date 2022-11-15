import 'package:pokedex/domain/gateway/repository/pokemon_repository.dart';
import 'package:pokedex/infrastructure/repository/pokemon/datasource/pokemon_cache_datasource.dart';
import 'package:pokedex/infrastructure/repository/pokemon/datasource/pokemon_remote_datasource.dart';
import 'package:pokedex/infrastructure/repository/pokemon/pokemon_repository.dart';

import 'container.dart';

void registerGateways() {
  sl.registerLazySingleton<IPokemonRepository>(
    () => PokemonRepositoryImpl(
      sl<IPokemonRemoteDatasource>(),
      sl<IPokemonCacheDatasource>(),
    ),
  );
}
