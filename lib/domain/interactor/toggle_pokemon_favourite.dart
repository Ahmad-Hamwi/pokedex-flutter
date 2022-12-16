import '../entity/pokemon_entity.dart';
import '../gateway/repository/pokemon_repository.dart';
import 'base_usecases.dart';

class TogglePokemonFavouriteUseCase extends RPUseCase<PokemonEntity, PokemonEntity> {
  final IPokemonRepository _repository;

  TogglePokemonFavouriteUseCase(this._repository);

  @override
  // ignore: avoid_renaming_method_parameters
  Future<PokemonEntity> execute(PokemonEntity pokemonToBeFavToggled) {
    final favToggled = pokemonToBeFavToggled.copyWith(
      isFavourite: !pokemonToBeFavToggled.isFavourite,
    );

    final savedResult = _repository.savePokemon(favToggled);

    return savedResult;
  }
}
