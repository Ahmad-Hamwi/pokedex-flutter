import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';

final themeData = ThemeData(
  textTheme: GoogleFonts.notoSansTextTheme(),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: SharedAxisPageTransitionsBuilder(
        transitionType: SharedAxisTransitionType.vertical,
      ),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
