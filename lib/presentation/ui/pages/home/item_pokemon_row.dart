import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/presentation/ui/pages/home/item_pokemon.dart';

class ItemPokemonRow extends StatelessWidget {
  final int horizontalItemCount;
  final List<PokemonEntity> pokemons;
  final Function(PokemonEntity pokemonEntity, int positionHorizontal)
      onViewDetails;
  final Function(PokemonEntity toggledEntity) onFavouriteToggled;

  const ItemPokemonRow({
    Key? key,
    required this.pokemons,
    required this.onViewDetails,
    required this.onFavouriteToggled,
    required this.horizontalItemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: () {
          List<Widget> itemsAndSpacers = [];
          for (int i = 0; i < horizontalItemCount; i++) {
            try {
              itemsAndSpacers.add(
                Expanded(
                  child: ItemPokemon(
                    pokemonEntity: pokemons[i],
                    onViewDetails: (clickedItem) => onViewDetails(
                      clickedItem,
                      pokemons.indexOf(clickedItem),
                    ),
                    onFavouriteToggled: onFavouriteToggled,
                  ),
                ),
              );
            } on RangeError {
              itemsAndSpacers.add(Expanded(child: Container()));
            }

            if (i != pokemons.length - 1) {
              itemsAndSpacers.add(const SizedBox(width: 10));
            }
          }
          return itemsAndSpacers;
        }(),
      ),
    );
  }
}
