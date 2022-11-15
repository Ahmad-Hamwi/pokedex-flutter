import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemBarsController extends StatelessWidget {
  final Widget child;

  final Color? systemBarColor;
  final Color? systemNavigationBarColor;

  final Brightness? statusBarIconBrightness;
  final Brightness? systemNavigationIconBrightness;

  const SystemBarsController({
    Key? key,
    this.systemBarColor,
    this.statusBarIconBrightness,
    this.systemNavigationBarColor,
    this.systemNavigationIconBrightness,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: systemBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: systemNavigationIconBrightness,
      ),
      child: child,
    );
  }
}
