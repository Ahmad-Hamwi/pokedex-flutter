// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_rmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonRemoteModel _$PokemonRemoteModelFromJson(Map<String, dynamic> json) =>
    PokemonRemoteModel(
      json['name'] as String,
      (json['types'] as List<dynamic>?)
          ?.map(
              (e) => PokemonTypeRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['height'] as num?,
      json['weight'] as num?,
      (json['stats'] as List<dynamic>?)
          ?.map(
              (e) => PokemonStatRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['url'] as String?,
    );

Map<String, dynamic> _$PokemonRemoteModelToJson(PokemonRemoteModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'types': instance.types,
      'height': instance.height,
      'weight': instance.weight,
      'stats': instance.stats,
      'url': instance.url,
    };
