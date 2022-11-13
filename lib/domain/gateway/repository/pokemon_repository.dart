import '../../entity/page.dart';
import '../../entity/pokemon_entity.dart';
import '../../interactor/get_pokemons_usecase.dart';

abstract class IPokemonRepository {
  Future<Page<PokemonEntity>> getPokemons(GetPokemonsUseCaseParams params);

  Future<PokemonEntity> getPokemon(int id);

  Future<PokemonEntity> savePokemon(PokemonEntity param);
}
