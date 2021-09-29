import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:malaysia_covid_tracker/home.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        animationDuration: Duration(milliseconds: 500),
        splash: 'assets/stayhome.png',
        splashIconSize: 250,
        nextScreen: HomePage(),
      ),
    );
  }
}
