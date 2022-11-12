import 'package:pokedex/domain/entity/page.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/interactor/get_pokemons_usecase.dart';
import 'package:pokedex/infrastructure/remote/dto/get_pokemons_request_params.dart';
import 'package:pokedex/infrastructure/remote/model/page.dart';
import 'package:pokedex/infrastructure/remote/service/pokemon_api_service.dart';
import 'package:pokedex/infrastructure/repository/base/datasource.dart';

abstract class IPokemonRemoteDatasource {
  Future<Page<PokemonEntity>> getPokemons(GetPokemonsUseCaseParams params);

  Future<PokemonEntity> getPokemon(int id);
}

class PokemonRemoteDatasourceImpl extends Datasource
    implements IPokemonRemoteDatasource {
  final IPokemonService service;

  PokemonRemoteDatasourceImpl(this.service);

  @override
  Future<PokemonEntity> getPokemon(int id) {
    return service
        .getPokemon(id)
        .then((remoteModel) => remoteModel.mapToEntity());
  }

  @override
  Future<Page<PokemonEntity>> getPokemons(GetPokemonsUseCaseParams params) {
    return service
        .getPokemons(
            PaginationRequestParams(params.pageNumber, params.pageSize))
        .then((remotePage) => remotePage.mapToEntity());
  }
}
