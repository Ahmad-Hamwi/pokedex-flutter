import 'package:flutter/material.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';
import 'package:pokedex/presentation/ui/util/string_utils.dart';

class LayoutPokemonStats extends StatelessWidget {
  final PokemonEntity pokemonEntity;

  const LayoutPokemonStats({Key? key, required this.pokemonEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Base Stats",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 0),
          const SizedBox(height: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: pokemonEntity.stats!
                .map((e) => _buildStat(e.name, e.baseStat.toInt()))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _buildStat(String key, int value) {
    final percent = value.toDouble() / 100.toDouble();
    final colorMap = {
      0: colorProgress0,
      20: colorProgress20,
      40: colorProgress40,
      60: colorProgress60,
      80: colorProgress80,
    };

    Color? color;
    colorMap.forEach((k, v) {
      if (value >= k && value <= k + 20) {
        color = colorMap[k];
      }
    });

    color ??= colorMap[80];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                key.capitalizeFirstLetter(),
                style: const TextStyle(fontSize: 14, color: colorTextLight),
              ),
              const SizedBox(width: 4),
              Text(
                value.toString(),
                style: const TextStyle(fontSize: 14, color: colorTextDark),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value: percent,
                valueColor: AlwaysStoppedAnimation<Color>(color!),
                backgroundColor: colorBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
