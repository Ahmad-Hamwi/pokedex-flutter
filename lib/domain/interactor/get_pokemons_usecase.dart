import 'package:pokedex/domain/entity/pokemon_stat_entity.dart';
import 'package:pokedex/domain/entity/pokemon_type_entity.dart';

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

    pokemons.map((pokemon) {
      num avgPowerBaseStat = 0;
      for (var stat in pokemon.stats!) {
        avgPowerBaseStat += stat.baseStat;
      }
      avgPowerBaseStat /= pokemon.stats!.length;
      final PokemonStatEntity avgPowerStat = PokemonStatEntity(
        -1,
        "Avg. Power",
        avgPowerBaseStat,
      );
      pokemon.stats!.add(avgPowerStat);
    });

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
