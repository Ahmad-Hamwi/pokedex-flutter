import 'package:flutter/material.dart';
import 'package:pokedex/di/container.dart';

import 'presentation/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DIContainer.initialize();

  await Future.delayed(const Duration(milliseconds: 1000));

  runApp(const PokedexApp());
}
