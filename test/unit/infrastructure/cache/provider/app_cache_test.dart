import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/infrastructure/cache/exception/exceptions.dart';
import 'package:pokedex/infrastructure/cache/provider/app_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../mocks/infrastructure/cache/cache_mocks_registry.mocks.dart';

void main() {
  late SharedPreferences prefsMock;
  late AppCacheImpl sut;

  setUp(() {
    prefsMock = MockSharedPreferences();
    sut = AppCacheImpl(prefsMock);
  });

  group("addPokemonToFavourite", () {
    test(
      "Adds an Id when cached list is not initialized",
      () async {
        when(prefsMock.getStringList(AppCacheImpl.favPokemonKey)) //
            .thenReturn(null);

        when(prefsMock.setStringList(AppCacheImpl.favPokemonKey, ["2"]))
            .thenAnswer((_) async => true);

        await sut.addPokemonToFavourite(2);
      },
    );

    test(
      "Adds an Id when cached list is initialized",
      () async {
        when(prefsMock.getStringList(AppCacheImpl.favPokemonKey))
            .thenReturn(["1", "3"]);

        when(prefsMock
                .setStringList(AppCacheImpl.favPokemonKey, ["1", "3", "2"]))
            .thenAnswer((_) async => true);

        await sut.addPokemonToFavourite(2);
      },
    );
  });

  group("getFavouritePokemons", () {
    test(
      "Gets an empty list if not initialized in shared prefs",
      () async {
        when(prefsMock.getStringList(AppCacheImpl.favPokemonKey))
            .thenReturn(null);

        final listOfFavIds = await sut.getFavouritePokemons();

        expect(listOfFavIds, []);
      },
    );

    test(
      "Gets a list of Ids when initialized in shared prefs",
      () async {
        when(prefsMock.getStringList(AppCacheImpl.favPokemonKey))
            .thenReturn(["1", "3", "2"]);

        final listOfFavIds = await sut.getFavouritePokemons();

        expect(listOfFavIds, [1, 3, 2]);
      },
    );
  });

  group("removePokemonFromFavourite", () {
    test("Removes an id from list", () async {
      when(prefsMock.getStringList(AppCacheImpl.favPokemonKey))
          .thenReturn(["1", "3", "2"]);

      when(prefsMock.setStringList(AppCacheImpl.favPokemonKey, ["1", "2"]))
          .thenAnswer((_) async => true);

      await sut.removePokemonFromFavourite(3);
    });

    test(
      "Throws NotCachedException when cached list is null",
      () async {
        when(prefsMock.getStringList(AppCacheImpl.favPokemonKey))
            .thenReturn(null);

        expect(() => sut.removePokemonFromFavourite(3),
            throwsA(isA<NotCachedException>()));
      },
    );

    test(
      "Throws NotCachedException when removing a non existing Id",
      () async {
        when(prefsMock.getStringList(AppCacheImpl.favPokemonKey))
            .thenReturn(["1", "2"]);

        expect(() => sut.removePokemonFromFavourite(3),
            throwsA(isA<NotCachedException>()));
      },
    );
  });
}
