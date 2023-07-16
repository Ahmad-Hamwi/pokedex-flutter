import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/entity/pokemon_stat_entity.dart';

void main() {
  group("calculateAvgStat", () {
    test("calculates average with stats populated", () {
      final stats = [
        PokemonStatEntity(1, "first Stat", 50),
        PokemonStatEntity(1, "second Stat", 60),
        PokemonStatEntity(1, "third Stat", 100),
      ];

      final pokemon = PokemonEntity(0, "name", "imageUrl", [], 1, 1, stats, false);

      final avgPowerStat = pokemon.calculateAvgStat();

      expect(avgPowerStat!.baseStat, 70);
    });

    test("calculates average with no stats populated", () {
      final stats = <PokemonStatEntity>[];

      final pokemon = PokemonEntity(0, "name", "imageUrl", [], 1, 1, stats, false);

      final avgPowerStat = pokemon.calculateAvgStat();

      expect(avgPowerStat!.baseStat, 0);
    });

    test("calculates average with null stats", () {
      const List<PokemonStatEntity>? stats = null;

      final pokemon = PokemonEntity(0, "name", "imageUrl", [], 1, 1, stats, false);

      final avgPowerStat = pokemon.calculateAvgStat();

      expect(avgPowerStat, null);
    });
  });
}
