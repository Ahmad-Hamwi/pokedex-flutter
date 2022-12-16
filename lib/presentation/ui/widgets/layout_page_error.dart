import 'package:flutter/material.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';

import 'confirm_button.dart';

class LayoutPageError extends StatelessWidget {
  final VoidCallback onRetry;

  const LayoutPageError({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Oops... something went wrong",
            style: TextStyle(color: colorTextDark, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: 12),
          ConfirmButton(
            onPressed: onRetry,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
