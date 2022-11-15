import 'package:flutter/material.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 32,
        width: 32,
        child: CircularProgressIndicator(
          color: colorPrimary,
        ),
      ),
    );
  }
}
