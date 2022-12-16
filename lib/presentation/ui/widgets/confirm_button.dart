import 'package:flutter/material.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 14)),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(colorPrimary),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
