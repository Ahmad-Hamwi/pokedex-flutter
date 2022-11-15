import 'package:flutter/material.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';

class LayoutPokemonProperties extends StatelessWidget {
  final PokemonEntity pokemonEntity;

  const LayoutPokemonProperties({Key? key, required this.pokemonEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildProperty("Height", pokemonEntity.height!),
            SizedBox(width: 42),
            _buildProperty("Weight", pokemonEntity.weight!),
            SizedBox(width: 42),
            _buildProperty(
                "BMI", num.parse(pokemonEntity.bmi!.toStringAsFixed(1))),
          ],
        ),
      ),
    );
  }

  Widget _buildProperty(String key, num value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          key,
          style: TextStyle(
            color: colorTextLight,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value.toString(),
          style: TextStyle(
            color: colorTextDark,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
