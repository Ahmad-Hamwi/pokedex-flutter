import 'package:pokedex/infrastructure/cache/exception/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAppCache {
  Future<List<int>> getFavouritePokemons();

  Future<void> addPokemonToFavourite(int id);

  Future<void> removePokemonFromFavourite(int id);
}

class AppCacheImpl implements IAppCache {
  static const String favPokemonKey = "FAV_POKEMON_KEY";

  final SharedPreferences _sharedPreferences;

  AppCacheImpl(this._sharedPreferences);

  @override
  Future<void> addPokemonToFavourite(int id) async {
    final favourites = _sharedPreferences.getStringList(favPokemonKey);

    if (favourites == null) {
      await _sharedPreferences.setStringList(favPokemonKey, [id.toString()]);
      return;
    }

    await _sharedPreferences
        .setStringList(favPokemonKey, [...favourites, id.toString()]);
  }

  @override
  Future<List<int>> getFavouritePokemons() async {
    final favourites = _sharedPreferences.getStringList(favPokemonKey);

    if (favourites == null) {
      return [];
    }

    return favourites.map((e) => int.parse(e)).toList();
  }

  @override
  Future<void> removePokemonFromFavourite(int id) async {
    final favourites = _sharedPreferences.getStringList(favPokemonKey);

    if (favourites == null || !favourites.any((e) => e == id.toString())) {
      throw NotCachedException("pokemon with $id not found");
    }

    favourites.remove(id.toString());

    await _sharedPreferences.setStringList(favPokemonKey, favourites);
  }
}
