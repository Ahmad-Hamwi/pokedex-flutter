// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/infrastructure/util/json_util.dart';

part 'pokemon_sprites_rmodel.g.dart';

@JsonSerializable()
class PokemonSpritesRemoteModel {
  PokemonSpritesOtherRemoteModel other;

  PokemonSpritesRemoteModel(this.other);

  factory PokemonSpritesRemoteModel.fromJson(JSON json) =>
      _$PokemonSpritesRemoteModelFromJson(json);
}

@JsonSerializable()
class PokemonSpritesOtherRemoteModel {
  @JsonKey(name: "official-artwork")
  PokemonOfficialArtworkRemoteModel artWork;

  PokemonSpritesOtherRemoteModel(this.artWork);

  factory PokemonSpritesOtherRemoteModel.fromJson(JSON json) =>
      _$PokemonSpritesOtherRemoteModelFromJson(json);
}

@JsonSerializable()
class PokemonOfficialArtworkRemoteModel {
  String front_default;

  PokemonOfficialArtworkRemoteModel(this.front_default);

  factory PokemonOfficialArtworkRemoteModel.fromJson(JSON json) =>
      _$PokemonOfficialArtworkRemoteModelFromJson(json);
}
