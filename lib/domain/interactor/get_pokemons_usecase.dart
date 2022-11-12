import '../entity/page.dart';
import '../entity/pokemon_entity.dart';
import '../gateway/repository/pokemon_repository.dart';
import 'base_usecases.dart';

class GetPokemonsUseCase
    extends RPUseCase<Page<PokemonEntity>, GetPokemonsUseCaseParams> {
  final IPokemonRepository _repository;

  GetPokemonsUseCase(this._repository);

  @override
  Future<Page<PokemonEntity>> execute(GetPokemonsUseCaseParams params) {
    return _repository.getPokemons(params);
  }
}

class GetPokemonsUseCaseParams {
  num pageNumber;
  num pageSize;

  GetPokemonsUseCaseParams(this.pageNumber, this.pageSize);
}
