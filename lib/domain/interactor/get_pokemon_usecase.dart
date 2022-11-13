import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/gateway/repository/pokemon_repository.dart';
import 'package:pokedex/domain/interactor/base_usecases.dart';

class GetPokemonUseCase extends RPUseCase<PokemonEntity, int> {
  final IPokemonRepository _repository;

  GetPokemonUseCase(this._repository);

  @override
  Future<PokemonEntity> execute(int id) => _repository.getPokemon(id);
}
