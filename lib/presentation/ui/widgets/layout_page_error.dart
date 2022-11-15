import 'package:flutter/material.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';

import 'confirm_button.dart';

class LayoutPageError extends StatelessWidget {
  final VoidCallback onRetry;

  const LayoutPageError({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "Oops... something went wrong",
              style: const TextStyle(color: colorTextDark, fontSize: 16),
            ),
          ),
          const SizedBox(width: 12),
          ConfirmButton(
            child: Text("Retry"),
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
