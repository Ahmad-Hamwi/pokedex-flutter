// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_stat_rmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonStatRemoteModel _$PokemonStatRemoteModelFromJson(
        Map<String, dynamic> json) =>
    PokemonStatRemoteModel(
      json['base_stat'] as num,
      PokemonStatDataRemoteModel.fromJson(json['stat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonStatRemoteModelToJson(
        PokemonStatRemoteModel instance) =>
    <String, dynamic>{
      'base_stat': instance.base_stat,
      'stat': instance.stat,
    };

PokemonStatDataRemoteModel _$PokemonStatDataRemoteModelFromJson(
        Map<String, dynamic> json) =>
    PokemonStatDataRemoteModel(
      json['name'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$PokemonStatDataRemoteModelToJson(
        PokemonStatDataRemoteModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
