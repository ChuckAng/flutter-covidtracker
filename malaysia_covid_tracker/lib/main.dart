import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:malaysia_covid_tracker/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(fontFamily: 'Lemonada',
           primaryColor: Colors.blue[900],
           accentColor: Colors.blue[700],
           ),
      home: SplashScreen(),
    );
  }
}
