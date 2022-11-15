import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';

final themeData = ThemeData(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: SharedAxisPageTransitionsBuilder(
        transitionType: SharedAxisTransitionType.vertical,
      ),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
