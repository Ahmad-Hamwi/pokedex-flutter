// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/infrastructure/util/json_util.dart';

part 'pokemon_stat_rmodel.g.dart';

@JsonSerializable()
class PokemonStatRemoteModel {
  num base_stat;
  PokemonStatDataRemoteModel stat;

  PokemonStatRemoteModel(this.base_stat, this.stat);

  factory PokemonStatRemoteModel.fromJson(JSON json) =>
      _$PokemonStatRemoteModelFromJson(json);
}

@JsonSerializable()
class PokemonStatDataRemoteModel {
  String name;
  String url;

  PokemonStatDataRemoteModel(this.name, this.url);

  factory PokemonStatDataRemoteModel.fromJson(JSON json) =>
      _$PokemonStatDataRemoteModelFromJson(json);
}
