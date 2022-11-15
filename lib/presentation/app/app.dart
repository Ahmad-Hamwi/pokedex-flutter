import 'package:flutter/material.dart';
import 'package:pokedex/di/container.dart';
import 'package:pokedex/presentation/app/theme_data.dart';
import 'package:pokedex/presentation/ui/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/presentation/ui/routes/route_generator.dart';

import '../ui/routes/routes.dart';

class PokedexApp extends StatefulWidget {
  const PokedexApp({super.key});

  @override
  State<PokedexApp> createState() => _PokedexAppState();
}

class _PokedexAppState extends State<PokedexApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: themeData,
      initialRoute: Routes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  @override
  void dispose() {
    sl<PokemonBlocMap>().dispose();
    super.dispose();
  }
}
