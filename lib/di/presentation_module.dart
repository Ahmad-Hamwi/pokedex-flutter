import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/interactor/get_favourites_count_usecase.dart';
import 'package:pokedex/domain/interactor/get_pokemons_usecase.dart';
import 'package:pokedex/domain/interactor/toggle_pokemon_favourite.dart';
import 'package:pokedex/presentation/ui/bloc/favourites_count/favourites_count_bloc.dart';
import 'package:pokedex/presentation/ui/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/presentation/ui/bloc/pokemons/pokemons_bloc.dart';

import 'container.dart';

void registerPresentation() {
  sl.registerFactory(() => PokemonsBloc(sl<GetPokemonsUseCase>()));
  sl.registerFactoryParam<PokemonBloc, PokemonEntity, void>(
      (pokemonEntity, _) =>
          PokemonBloc(sl<TogglePokemonFavouriteUseCase>(), pokemonEntity));
  sl.registerLazySingleton(() => PokemonBlocMap());
  sl.registerFactory<FavouritesCountBloc>(
      () => FavouritesCountBloc(sl<GetFavouritesCountUseCase>()));
}
