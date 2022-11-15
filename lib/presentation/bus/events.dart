import 'package:pokedex/domain/entity/pokemon_entity.dart';

abstract class BusEvent {}

class FavouriteToggledBusEvent extends BusEvent {
  final PokemonEntity pokemonEntity;

  FavouriteToggledBusEvent(this.pokemonEntity);
}
