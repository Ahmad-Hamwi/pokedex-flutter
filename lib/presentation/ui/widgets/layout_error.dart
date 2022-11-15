import 'package:flutter/material.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';

import 'confirm_button.dart';

class LayoutError extends StatelessWidget {
  final VoidCallback onRetry;

  const LayoutError({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const FractionalOffset(0.5, 0.3),
      margin: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Oops... Something went wrong, try again later.",
            style: TextStyle(color: colorTextDark, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ConfirmButton(
            onPressed: onRetry,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
