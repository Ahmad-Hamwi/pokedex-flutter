import 'package:pokedex/domain/gateway/repository/pokemon_repository.dart';
import 'package:pokedex/domain/interactor/base_usecases.dart';

class GetFavouritesCountUseCase extends ReturnUseCase<int> {

  final IPokemonRepository _pokemonRepository;

  GetFavouritesCountUseCase(this._pokemonRepository);

  @override
  Future<int> execute() => _pokemonRepository.getFavouritesCount();
}