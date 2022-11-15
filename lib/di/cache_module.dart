import 'dart:developer';

import 'package:pokedex/infrastructure/cache/provider/app_cache.dart';
import 'package:pokedex/infrastructure/repository/pokemon/datasource/pokemon_cache_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'container.dart';

Future<void> registerCache() async {
  try {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    sl.registerLazySingleton<IAppCache>(
      () => AppCacheImpl(sl<SharedPreferences>()),
    );
  } on Exception catch (e) {
    log(e.toString());
  } on Error catch (e) {
    if (e.stackTrace != null) log(e.stackTrace.toString());
  }

  sl.registerLazySingleton<IPokemonCacheDatasource>(
      () => PokemonCacheDatasourceImpl(sl<IAppCache>()));
}
