import 'package:flutter/material.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';
import 'package:pokedex/presentation/ui/util/string_utils.dart';
import 'package:pokedex/presentation/ui/widgets/remote_image.dart';

class PokemonAppBarContent extends StatelessWidget {
  final double appBarHeight = 66.0;
  final PokemonEntity pokemonEntity;

  const PokemonAppBarContent({super.key, required this.pokemonEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: typeColorMap[pokemonEntity.types![0].name],
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: appBarHeight + 20, left: 16),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokemonEntity.name.capitalizeFirstLetter(),
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  pokemonEntity.types!
                      .map((e) => e.name.capitalizeFirstLetter())
                      .toList()
                      .toString()
                      .replaceAll(RegExp(r"[\[\]]"), ""),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(bottom: 14, left: 16),
            child: Text(
              '#${pokemonEntity.id.toString().padLeft(3, '0')}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Container(
              width: (MediaQuery.of(context).size.width * 0.4),
              margin: EdgeInsets.only(right: 16),
              child: AspectRatio(
                aspectRatio: 1,
                child: RemoteImage(src: pokemonEntity.imageUrl),
              ),
            ),
          )
        ],
      ),
    );
  }
}
