import '../entity/pokemon_entity.dart';
import '../gateway/repository/pokemon_repository.dart';
import 'base_usecases.dart';

class TogglePokemonFavourite extends RPUseCase<PokemonEntity, PokemonEntity> {
  final IPokemonRepository _repository;

  TogglePokemonFavourite(this._repository);

  @override
  Future<PokemonEntity> execute(PokemonEntity pokemonToBeFavToggled) {
    final favToggled = pokemonToBeFavToggled.copyWith(
      isFavourite: pokemonToBeFavToggled.isFavourite,
    );

    final savedResult = _repository.savePokemon(favToggled);

    return savedResult;
  }
}
