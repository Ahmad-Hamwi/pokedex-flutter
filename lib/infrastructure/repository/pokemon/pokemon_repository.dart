import 'package:pokedex/domain/entity/page.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/gateway/repository/pokemon_repository.dart';
import 'package:pokedex/domain/interactor/get_pokemons_usecase.dart';
import 'package:pokedex/infrastructure/repository/base/repository.dart';
import 'package:pokedex/infrastructure/repository/pokemon/datasource/pokemon_remote_datasource.dart';

import 'datasource/pokemon_cache_datasource.dart';

class PokemonRepositoryImpl extends Repository implements IPokemonRepository {
  final IPokemonRemoteDatasource _pokemonRemoteDatasource;
  final IPokemonCacheDatasource _pokemonCacheDatasource;

  PokemonRepositoryImpl(
      this._pokemonRemoteDatasource, this._pokemonCacheDatasource);

  @override
  Future<PageEntity<PokemonEntity>> getPokemons(
      GetPokemonsUseCaseParams params) async {
    final remotePokemonsPage =
        await _pokemonRemoteDatasource.getPokemons(params);

    final remoteDetailedPokemons = await Future.wait(
      remotePokemonsPage.items
          .map((t) async => await _pokemonRemoteDatasource.getPokemon(t.id))
          .toList(),
    );

    final remoteDetailedPokemonsPage = PageEntity(
      remotePokemonsPage.pageNumber,
      remotePokemonsPage.totalPages,
      remoteDetailedPokemons,
    );

    final cachedFavourites =
        await _pokemonCacheDatasource.getFavouritePokemons();
    final pokemonsWithCorrectFavourite = remoteDetailedPokemonsPage.map(
        (remotePokemon) =>
            cachedFavourites.any((favId) => remotePokemon.id == favId) //is fav?
                ? remotePokemon.copyWith(isFavourite: true) //mark it as fav
                : remotePokemon); //otherwise take it as it is

    return pokemonsWithCorrectFavourite;
  }

  @override
  Future<PageEntity<PokemonEntity>> getFavouritePokemons(
      GetPokemonsUseCaseParams params) async {
    final cachedFavouritesIds =
        await _pokemonCacheDatasource.getFavouritePokemons();

    final remoteDetailedPokemons = (await Future.wait(
      cachedFavouritesIds
          .map((id) async => await _pokemonRemoteDatasource.getPokemon(id))
          .toList(),
    )).map((pokemon) => pokemon.copyWith(isFavourite: true)).toList();

    final remoteDetailedPokemonsPage = PageEntity(
      params.pageNumber,
      (cachedFavouritesIds.length / params.pageSize).ceil(),
      remoteDetailedPokemons,
    );

    return remoteDetailedPokemonsPage;
  }

  @override
  Future<PokemonEntity> getPokemon(int id) async {
    final remotePokemon = await _pokemonRemoteDatasource.getPokemon(id);
    final cachedFavourites =
        await _pokemonCacheDatasource.getFavouritePokemons();
    if (cachedFavourites.any((favId) => favId == id)) {
      return remotePokemon.copyWith(isFavourite: true);
    } else {
      return remotePokemon;
    }
  }

  @override
  Future<PokemonEntity> savePokemon(PokemonEntity pokemonToBeSaved) async {
    await _pokemonCacheDatasource.setFavouritePokemon(
        pokemonToBeSaved.id, pokemonToBeSaved.isFavourite);

    return pokemonToBeSaved;
  }

  @override
  Future<int> getFavouritesCount() async {
    return (await _pokemonCacheDatasource.getFavouritePokemons()).length;
  }
}
