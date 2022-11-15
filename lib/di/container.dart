import 'package:get_it/get_it.dart';
import 'package:pokedex/di/presentation_module.dart';

import 'cache_module.dart';
import 'gateway_module.dart';
import 'interactor_module.dart';
import 'network_module.dart';

final GetIt sl = GetIt.instance;

class DIContainer {
  static bool _isReady = false;

  static Future<void> initialize() async {
    if (_isReady) {
      return;
    }
    _isReady = true;
    await _initContainer();
  }
}

Future<void> _initContainer() async {
  await registerCache();
  registerNetwork();
  registerGateways();
  registerUseCases();
  registerPresentation();
  await sl.allReady();
}
