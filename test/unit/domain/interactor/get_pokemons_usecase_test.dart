import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/domain/entity/page.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/entity/pokemon_stat_entity.dart';
import 'package:pokedex/domain/interactor/get_pokemons_usecase.dart';

import '../../../mocks/domain/repository/repositories_mocks_registry.mocks.dart';

class _FakePokemonEntityWithID1 extends Fake implements PokemonEntity {
  @override
  int get id => 1;

  @override
  List<PokemonStatEntity>? get stats => null;
}

class _FakeFavPokemonEntityWithID1 extends Fake implements PokemonEntity {
  @override
  int get id => 1;

  @override
  bool get isFavourite => true;

  @override
  List<PokemonStatEntity>? get stats => null;
}

void main() {
  late MockIPokemonRepository mockPokemonRepository;
  late GetPokemonsUseCase sut;

  setUp(() {
    mockPokemonRepository = MockIPokemonRepository();
    sut = GetPokemonsUseCase(mockPokemonRepository);
  });

  group("GetPokemonsUseCase", () {
    test("fetches non-favourite pokemons from a repository", () async {
      // arrange
      final sutParams = GetPokemonsUseCaseParams(1, 1, false);
      when(
        mockPokemonRepository.getPokemons(sutParams),
      ).thenAnswer(
        (_) async => PageEntity(1, 1, [_FakePokemonEntityWithID1()]),
      );

      // act
      final result = await sut.execute(sutParams);

      // assert
      expect(
        result,
        isA<PageEntity<PokemonEntity>>().having(
          (page) => page.items[0],
          "page.items[0]",
          isA<PokemonEntity>().having((pokemon) => pokemon.id, "pokemon.id", 1),
        ),
      );
    });

    test("fetches favourite pokemons from a repository", () async {
      // arrange
      final sutParams = GetPokemonsUseCaseParams(1, 1, true);
      when(
        mockPokemonRepository.getFavouritePokemons(sutParams),
      ).thenAnswer(
        (_) async => PageEntity(1, 1, [_FakeFavPokemonEntityWithID1()]),
      );

      // act
      final result = await sut.execute(sutParams);

      // assert
      expect(
        result,
        isA<PageEntity<PokemonEntity>>().having(
          (page) => page.items[0],
          "page.items[0]",
          isA<PokemonEntity>()
              .having((pokemon) => pokemon.id, "pokemon.id", 1)
              .having(
                (pokemon) => pokemon.isFavourite,
                "pokemon.isFavourite",
                true,
              ),
        ),
      );
    });

    test(
      "throws when fetching non-favourite pokemons from a repository",
      () async {
        // arrange
        when(mockPokemonRepository.getPokemons(any)).thenThrow(Exception());

        // act
        final futureResult = sut.execute(GetPokemonsUseCaseParams(1, 1, false));

        // assert
        await expectLater(futureResult, throwsException);
      },
    );

    test(
      "throws when fetching favourite pokemons from a repository",
      () async {
        // arrange
        when(mockPokemonRepository.getFavouritePokemons(any))
            .thenThrow(Exception());

        // act
        final futureResult = sut.execute(GetPokemonsUseCaseParams(1, 1, true));

        // assert
        await expectLater(futureResult, throwsException);
      },
    );
  });
}
