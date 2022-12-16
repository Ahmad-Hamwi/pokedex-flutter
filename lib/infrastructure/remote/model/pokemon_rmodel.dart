import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/entity/pokemon_stat_entity.dart';
import 'package:pokedex/domain/entity/pokemon_type_entity.dart';
import 'package:pokedex/infrastructure/remote/model/pokemon_sprites_rmodel.dart';
import 'package:pokedex/infrastructure/remote/model/pokemon_stat_rmodel.dart';
import 'package:pokedex/infrastructure/remote/model/pokemon_type_rmodel.dart';
import 'package:pokedex/infrastructure/remote/model/remote_model.dart';
import 'package:pokedex/infrastructure/util/json_util.dart';

import '../../util/url_util.dart';

part 'pokemon_rmodel.g.dart';

@JsonSerializable()
class PokemonRemoteModel extends RemoteModel {
  final String name;
  final List<PokemonTypeRemoteModel>? types;
  final num? height;
  final num? weight;
  final List<PokemonStatRemoteModel>? stats;
  final String? url;
  final PokemonSpritesRemoteModel? sprites;

  PokemonRemoteModel(
    this.name,
    this.types,
    this.height,
    this.weight,
    this.stats,
    this.url,
    this.sprites,
  );

  factory PokemonRemoteModel.fromJson(JSON json) =>
      _$PokemonRemoteModelFromJson(json);

  @override
  PokemonEntity mapToEntity() => PokemonEntity(
        UrlUtils.extractLastUrlParamAsInt(url!)!,
        name,
        sprites?.other.artWork.front_default,
        types == null
            ? null
            : types!
                .map((e) => PokemonTypeEntity(
                      UrlUtils.extractLastUrlParamAsInt(e.type.url)!,
                      e.type.name,
                    ))
                .toList(),
        height,
        weight,
        stats == null
            ? null
            : stats!
                .map((e) => PokemonStatEntity(
                      UrlUtils.extractLastUrlParamAsInt(e.stat.url)!,
                      e.stat.name,
                      e.base_stat,
                    ))
                .toList(),
        false,
      );

  PokemonRemoteModel copyWith({
    String? name,
    List<PokemonTypeRemoteModel>? types,
    num? height,
    num? weight,
    List<PokemonStatRemoteModel>? stats,
    String? url,
    PokemonSpritesRemoteModel? sprites,
  }) {
    return PokemonRemoteModel(
      name ?? this.name,
      types ?? this.types,
      height ?? this.height,
      weight ?? this.weight,
      stats ?? this.stats,
      url ?? this.url,
      sprites ?? this.sprites,
    );
  }
}
