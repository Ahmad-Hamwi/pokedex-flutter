import 'package:pokedex/domain/entity/pokemon_stat_entity.dart';
import 'package:pokedex/domain/entity/pokemon_type_entity.dart';

import 'entity.dart';

class PokemonEntity extends Entity {
  final String name;
  final String? imageUrl;
  final List<PokemonTypeEntity>? types;

  final num? height;
  final num? weight;

  num? get bmi => (weight == null || height == null)
      ? null
      : (weight! / (height! * height!));

  final List<PokemonStatEntity>? stats;

  final bool isFavourite;

  PokemonEntity(
    int id,
    this.name,
    this.imageUrl,
    this.types,
    this.height,
    this.weight,
    this.stats,
    this.isFavourite,
  ) : super(id);

  PokemonEntity copyWith({
    String? name,
    String? imageUrl,
    List<PokemonTypeEntity>? types,
    num? height,
    num? weight,
    List<PokemonStatEntity>? stats,
    bool? isFavourite,
  }) =>
      PokemonEntity(
        id,
        name ?? this.name,
        imageUrl ?? this.imageUrl,
        types ?? this.types,
        height ?? this.height,
        weight ?? this.weight,
        stats ?? this.stats,
        isFavourite ?? this.isFavourite,
      );
}
