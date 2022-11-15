import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../routes/routes.dart';
import '../widgets/system_bars_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (_) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SystemBarsController(
      statusBarIconBrightness: Brightness.light,
      systemBarColor: Colors.transparent,
      systemNavigationIconBrightness: Brightness.light,
      systemNavigationBarColor: colorPrimary,
      child: Container(
        color: colorPrimary,
        child: Center(
          child: Image.asset('assets/images/img_splash_logo.png'),
        ),
      ),
    );
  }
}
