import 'package:pokedex/domain/gateway/repository/pokemon_repository.dart';
import 'package:pokedex/domain/interactor/get_favourites_count_usecase.dart';
import 'package:pokedex/domain/interactor/get_pokemons_usecase.dart';
import 'package:pokedex/domain/interactor/toggle_pokemon_favourite.dart';

import 'container.dart';

void registerUseCases() {
  sl.registerLazySingleton<GetPokemonsUseCase>(
    () => GetPokemonsUseCase(sl<IPokemonRepository>()),
  );

  sl.registerLazySingleton<TogglePokemonFavouriteUseCase>(
      () => TogglePokemonFavouriteUseCase(sl<IPokemonRepository>()));

  sl.registerLazySingleton<GetFavouritesCountUseCase>(
      () => GetFavouritesCountUseCase(sl<IPokemonRepository>()));
}
