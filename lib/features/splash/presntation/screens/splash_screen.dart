
import 'package:flutter/material.dart';
import 'package:taskes/core/color.dart';
import 'package:taskes/features/splash/presntation/screens/widgets/splash_screen_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: mainColor,
      body: SplashScreenBody(),
    );
  }
}
