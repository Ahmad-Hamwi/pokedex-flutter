import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/domain/interactor/toggle_pokemon_favourite.dart';

import '../../../mocks/domain/entity/entities_mocks_registry.mocks.dart';
import '../../../mocks/domain/repository/repositories_mocks_registry.mocks.dart';

void main() {
  group("Test TogglePokemonFavouriteUseCase", () {
    final repoMock = MockIPokemonRepository();
    final toBeToggledMock = MockPokemonEntity();
    final toggledMock = MockPokemonEntity();
    final savedMock = MockPokemonEntity();

    when(repoMock.savePokemon(toggledMock))
        .thenAnswer((_) => Future.value(savedMock));

    final useCaseActual = TogglePokemonFavouriteUseCase(repoMock);

    test("that makes an `infavourite` pokemon as `favourite`", () async {
      when(toBeToggledMock.isFavourite).thenReturn(false);
      when(toggledMock.isFavourite).thenReturn(true);
      when(toBeToggledMock.copyWith(isFavourite: true)).thenReturn(toggledMock);
      when(savedMock.isFavourite).thenReturn(true);

      final toggledFavPokemon = await useCaseActual.execute(toBeToggledMock);

      expect(toggledFavPokemon.isFavourite, true);
    });

    test("that makes a `favourite` pokemon as `infavourite`", () async {
      when(toBeToggledMock.isFavourite).thenReturn(true);
      when(toggledMock.isFavourite).thenReturn(false);
      when(toBeToggledMock.copyWith(isFavourite: false))
          .thenReturn(toggledMock);
      when(savedMock.isFavourite).thenReturn(false);

      final toggledFavPokemon = await useCaseActual.execute(toBeToggledMock);

      expect(toggledFavPokemon.isFavourite, false);
    });
  });
}
