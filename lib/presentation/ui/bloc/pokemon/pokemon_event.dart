part of 'pokemon_bloc.dart';

abstract class PokemonEvent {}

class UpdatePokemonEvent extends PokemonEvent {
  final PokemonEntity pokemonEntity;

  UpdatePokemonEvent(this.pokemonEntity);
}

class TogglePokemonFavouriteEvent extends PokemonEvent {
  final PokemonEntity pokemonToBeToggled;

  TogglePokemonFavouriteEvent(this.pokemonToBeToggled);
}
