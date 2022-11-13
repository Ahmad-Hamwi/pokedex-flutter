import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/infrastructure/cache/exception/exceptions.dart';
import 'package:pokedex/infrastructure/cache/provider/app_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_cache_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group("AppCacheImpl tests", () {
    final prefsMock = MockSharedPreferences();
    final appCacheActual = AppCacheImpl(prefsMock);

    test(
      "addPokemonToFavourite adds an Id when cached list is not initialized",
      () async {
        when(prefsMock.getStringList(AppCacheImpl.favPokemonKey)) //
            .thenReturn(null);

        when(prefsMock.setStringList(AppCacheImpl.favPokemonKey, ["2"]))
            .thenAnswer((_) async => true);

        await appCacheActual.addPokemonToFavourite(2);
      },
    );

    test(
      "addPokemonToFavourite adds an Id when cached list is initialized",
      () async {
        when(prefsMock.getStringList(AppCacheImpl.favPokemonKey))
            .thenReturn(["1", "3"]);

        when(prefsMock
                .setStringList(AppCacheImpl.favPokemonKey, ["1", "3", "2"]))
            .thenAnswer((_) async => true);

        await appCacheActual.addPokemonToFavourite(2);
      },
    );

    test(
      "getFavouritePokemons gets an empty list if not initialized in shared prefs",
      () async {
        when(prefsMock.getStringList(AppCacheImpl.favPokemonKey))
            .thenReturn(null);

        final listOfFavIds = await appCacheActual.getFavouritePokemons();

        expect(listOfFavIds, []);
      },
    );

    test(
      "getFavouritePokemons gets a list of Ids when initialized in shared prefs",
      () async {
        when(prefsMock.getStringList(AppCacheImpl.favPokemonKey))
            .thenReturn(["1", "3", "2"]);

        final listOfFavIds = await appCacheActual.getFavouritePokemons();

        expect(listOfFavIds, [1, 3, 2]);
      },
    );

    test("removePokemonFromFavourite removes an id from list", () async {
      when(prefsMock.getStringList(AppCacheImpl.favPokemonKey))
          .thenReturn(["1", "3", "2"]);

      when(prefsMock.setStringList(AppCacheImpl.favPokemonKey, ["1", "2"]))
          .thenAnswer((_) async => true);

      await appCacheActual.removePokemonFromFavourite(3);
    });

    test(
      "removePokemonFromFavourite throws NotCachedException when cached list is null",
      () async {
        when(prefsMock.getStringList(AppCacheImpl.favPokemonKey))
            .thenReturn(null);

        expect(() => appCacheActual.removePokemonFromFavourite(3),
            throwsA(isA<NotCachedException>()));
      },
    );

    test(
      "removePokemonFromFavourite throws NotCachedException when removing a non existing Id",
      () async {
        when(prefsMock.getStringList(AppCacheImpl.favPokemonKey))
            .thenReturn(["1", "2"]);

        expect(() => appCacheActual.removePokemonFromFavourite(3),
            throwsA(isA<NotCachedException>()));
      },
    );
  });
}
