import 'package:pokedex/domain/gateway/repository/pokemon_repository.dart';
import 'package:pokedex/domain/interactor/base_usecases.dart';

class GetFavouritesCountUseCase extends UseCase<int, void> {

  final IPokemonRepository _pokemonRepository;

  GetFavouritesCountUseCase(this._pokemonRepository);

  @override
  Future<int> execute([void params]) => _pokemonRepository.getFavouritesCount();
}