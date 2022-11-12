import 'package:pokedex/infrastructure/util/json_util.dart';
import 'package:pokedex/infrastructure/remote/const/api_endpoints.dart';

import '../client/api_client.dart';
import '../dto/get_pokemons_request_params.dart';
import '../model/page.dart';
import '../model/pokemon_rmodel.dart';

abstract class IPokemonService {
  Future<PageRemoteModel<PokemonRemoteModel>> getPokemons(
      PaginationRequestParams params);

  Future<PokemonRemoteModel> getPokemon(int id);
}

class PokemonApiService implements IPokemonService {
  final IApiClient _apiClient;

  PokemonApiService(this._apiClient);

  @override
  Future<PageRemoteModel<PokemonRemoteModel>> getPokemons(
      PaginationRequestParams requestParams) {
    return _apiClient
        .get(ApiEndpoints.pokemon, params: requestParams.queryParams)
        .then((response) => PageRemoteModel.fromJson(
              response.data,
              (pokeJson) => PokemonRemoteModel.fromJson(pokeJson as JSON),
            ));
  }

  @override
  Future<PokemonRemoteModel> getPokemon(int id) {
    return _apiClient
        .get("${ApiEndpoints.pokemon}/$id/")
        .then((response) => PokemonRemoteModel.fromJson(response.data));
  }
}
