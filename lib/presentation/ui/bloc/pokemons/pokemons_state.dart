import 'package:pokedex/domain/entity/page.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';

abstract class PokemonsState {}

class PokemonsLoading extends PokemonsState {}

class PokemonsLoaded extends PokemonsState {
  final PageEntity<PokemonEntity> pokemonPage;

  PokemonsLoaded(this.pokemonPage);
}

class PokemonsError extends PokemonsState {
  final dynamic error;

  PokemonsError(this.error);
}
