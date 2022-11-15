import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/di/container.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/presentation/ui/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/presentation/ui/util/string_utils.dart';
import 'package:pokedex/presentation/ui/widgets/remote_image.dart';

import '../../resources/colors.dart';

class ItemPokemon extends StatelessWidget {
  final PokemonEntity pokemonEntity;
  final Function(PokemonEntity pokemonEntity) onViewDetails;

  ItemPokemon({
    Key? key,
    required this.pokemonEntity,
    required this.onViewDetails,
  }) : super(key: key) {
    sl<PokemonBlocMap>().getBloc(pokemonEntity.id,
        defaultBlocBuilder: () =>
            sl.get<PokemonBloc>(param1: pokemonEntity));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onViewDetails(pokemonEntity),
      child: AspectRatio(
        aspectRatio: 110 / 186,
        child: Card(
          elevation: 0,
          color: colorWhite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: typeColorMap[pokemonEntity.types![0].name],
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RemoteImage(
                      src: pokemonEntity.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('#${pokemonEntity.id.toString().padLeft(3, '0')}',
                        style: TextStyle(fontSize: 12, color: colorTextLight)),
                    SizedBox(height: 2),
                    Text(
                      pokemonEntity.name.capitalizeFirstLetter(),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: colorTextDark),
                    ),
                    SizedBox(height: 12),
                    Text(
                      pokemonEntity.types!
                          .map((e) => e.name.capitalizeFirstLetter())
                          .toList()
                          .toString()
                          .replaceAll(RegExp(r"[\[\]]"), ""),
                      style: TextStyle(fontSize: 12, color: colorTextLight),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
