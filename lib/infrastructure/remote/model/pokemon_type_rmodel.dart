import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/infrastructure/util/json_util.dart';

part 'pokemon_type_rmodel.g.dart';

@JsonSerializable()
class PokemonTypeRemoteModel {
  final PokemonTypeDataRemoteModel type;

  PokemonTypeRemoteModel(this.type);

  factory PokemonTypeRemoteModel.fromJson(JSON json) =>
      _$PokemonTypeRemoteModelFromJson(json);
}

@JsonSerializable()
class PokemonTypeDataRemoteModel {
  final String name;
  final String url;

  PokemonTypeDataRemoteModel(this.name, this.url);

  factory PokemonTypeDataRemoteModel.fromJson(JSON json) =>
      _$PokemonTypeDataRemoteModelFromJson(json);
}
