import '../../entity/page.dart';
import '../../entity/pokemon_entity.dart';
import '../../interactor/get_pokemons_usecase.dart';

abstract class IPokemonRepository {
  Future<PageEntity<PokemonEntity>> getPokemons(GetPokemonsUseCaseParams params);

  Future<PageEntity<PokemonEntity>> getFavouritePokemons(GetPokemonsUseCaseParams params);

  Future<PokemonEntity> getPokemon(int id);

  Future<PokemonEntity> savePokemon(PokemonEntity param);

  Future<int> getFavouritesCount();
}
