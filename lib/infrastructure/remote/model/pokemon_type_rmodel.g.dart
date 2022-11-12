// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_type_rmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonTypeRemoteModel _$PokemonTypeRemoteModelFromJson(
        Map<String, dynamic> json) =>
    PokemonTypeRemoteModel(
      PokemonTypeDataRemoteModel.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonTypeRemoteModelToJson(
        PokemonTypeRemoteModel instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

PokemonTypeDataRemoteModel _$PokemonTypeDataRemoteModelFromJson(
        Map<String, dynamic> json) =>
    PokemonTypeDataRemoteModel(
      json['name'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$PokemonTypeDataRemoteModelToJson(
        PokemonTypeDataRemoteModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
