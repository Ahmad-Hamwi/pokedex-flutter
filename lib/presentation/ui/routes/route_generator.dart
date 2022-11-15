import 'package:flutter/material.dart';
import 'package:pokedex/presentation/ui/routes/routes.dart';

import '../pages/home/home_page.dart';
import '../pages/pokemon/pokemon_page.dart';
import '../pages/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case Routes.pokemon:
        return MaterialPageRoute(
          builder: (_) => PokemonPage(pokemonId: settings.arguments as int),
        );

      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      default:
        throw UnimplementedError();
    }
  }
}
