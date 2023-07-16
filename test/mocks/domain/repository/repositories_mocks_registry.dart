import 'package:mockito/annotations.dart';
import 'package:pokedex/domain/gateway/repository/pokemon_repository.dart';

@GenerateNiceMocks([
  MockSpec<IPokemonRepository>(),
])
class _RepositoriesMocksRegistry {}
