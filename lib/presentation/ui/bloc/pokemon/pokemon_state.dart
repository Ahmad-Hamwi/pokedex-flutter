part of 'pokemon_bloc.dart';

abstract class PokemonState {}

class PokemonLoaded extends PokemonState {
  final PokemonEntity pokemonEntity;

  PokemonLoaded(this.pokemonEntity);
}

class PokemonFavToggledState extends PokemonLoaded {
  PokemonFavToggledState(super.pokemonEntity);
}

class PokemonErrorFavToggleState extends PokemonLoaded {
  final dynamic error;

  PokemonErrorFavToggleState(PokemonEntity pokemonEntity, this.error)
      : super(pokemonEntity);
}
