import '../entity/page.dart';
import '../entity/pokemon_entity.dart';
import '../gateway/repository/pokemon_repository.dart';
import 'base_usecases.dart';

class GetPokemonsUseCase
    extends RPUseCase<PageEntity<PokemonEntity>, GetPokemonsUseCaseParams> {
  final IPokemonRepository _repository;

  GetPokemonsUseCase(this._repository);

  @override
  Future<PageEntity<PokemonEntity>> execute(
      GetPokemonsUseCaseParams params) async {
    final pokemons = params.isFavourite
        ? await _repository.getFavouritePokemons(params)
        : await _repository.getPokemons(params);

    pokemons.map((pokemon) => pokemon..stats?.add(pokemon.calculateAvgStat()!));

    return pokemons;
  }
}

class GetPokemonsUseCaseParams {
  num pageNumber;
  num pageSize;

  bool isFavourite;

  GetPokemonsUseCaseParams(this.pageNumber, this.pageSize,
      [this.isFavourite = false]);
}
