import 'package:flutter/material.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';

import 'confirm_button.dart';

class LayoutEmpty extends StatelessWidget {
  final String? text;
  final VoidCallback onRefresh;

  const LayoutEmpty({Key? key, required this.onRefresh, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const FractionalOffset(0.5, 0.3),
      margin: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text ?? "No data found",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: colorTextDark,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ConfirmButton(
            onPressed: onRefresh,
            child: const Text("Refresh"),
          ),
        ],
      ),
    );
  }
}
