import 'package:flutter/material.dart';
import 'package:pokedex/di/container.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/presentation/ui/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/presentation/ui/util/string_utils.dart';
import 'package:pokedex/presentation/ui/widgets/remote_image.dart';

import '../../resources/colors.dart';

class ItemPokemon extends StatelessWidget {
  final PokemonEntity pokemon;
  final Function(PokemonEntity pokemonEntity) onViewDetails;

  ItemPokemon({
    Key? key,
    required this.pokemon,
    required this.onViewDetails,
  }) : super(key: key) {
    sl<PokemonBlocMap>().getBloc(pokemon.id,
        defaultBlocBuilder: () =>
            sl.get<PokemonBloc>(param1: pokemon));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onViewDetails(pokemon),
      child: AspectRatio(
        aspectRatio: 110 / 186,
        child: Card(
          elevation: 0,
          color: colorWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: typeColorMap[pokemon.types![0].name],
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RemoteImage(
                      src: pokemon.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('#${pokemon.id.toString().padLeft(3, '0')}',
                          style: const TextStyle(fontSize: 12, color: colorTextLight)),
                      const SizedBox(height: 2),
                      Text(
                        pokemon.name.capitalizeFirstLetter(),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorTextDark),
                      ),
                      const Spacer(),
                      Text(
                        pokemon.types!
                            .map((e) => e.name.capitalizeFirstLetter())
                            .toList()
                            .toString()
                            .replaceAll(RegExp(r"[\[\]]"), ""),
                        style: const TextStyle(fontSize: 12, color: colorTextLight),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
