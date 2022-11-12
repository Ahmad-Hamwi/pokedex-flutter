import 'package:pokedex/infrastructure/cache/provider/app_cache.dart';

abstract class IPokemonCacheDatasource {
  Future<List<int>> getFavouritePokemons();

  Future<void> setFavouritePokemon(int id, bool isFavourite);
}

class PokemonCacheDatasourceImpl extends IPokemonCacheDatasource {
  final IAppCache _appCache;

  PokemonCacheDatasourceImpl(this._appCache);

  @override
  Future<List<int>> getFavouritePokemons() => _appCache.getFavouritePokemons();

  @override
  Future<void> setFavouritePokemon(int id, bool isFavourite) => isFavourite
      ? _appCache.addPokemonToFavourite(id)
      : _appCache.removePokemonFromFavourite(id);
}
