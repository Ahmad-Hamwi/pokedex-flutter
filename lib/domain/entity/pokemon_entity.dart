import 'package:pokedex/domain/entity/pokemon_stat_entity.dart';
import 'package:pokedex/domain/entity/pokemon_type_entity.dart';

import 'entity.dart';

class PokemonEntity extends Entity {
  final String name;
  final List<PokemonTypeEntity> types;

  final num height;
  final num weight;

  num get bmi => weight / (height * height);

  final List<PokemonStatEntity> stats;

  final bool isFavourite;

  PokemonEntity(
    int id,
    this.name,
    this.types,
    this.height,
    this.weight,
    this.stats,
    this.isFavourite,
  ) : super(id);

  PokemonEntity copyWith({
    String? name,
    List<PokemonTypeEntity>? types,
    num? height,
    num? weight,
    List<PokemonStatEntity>? stats,
    bool? isFavourite,
  }) =>
      PokemonEntity(
        this.id,
        name ?? this.name,
        types ?? this.types,
        height ?? this.height,
        weight ?? this.weight,
        stats ?? this.stats,
        isFavourite ?? this.isFavourite,
      );
}
