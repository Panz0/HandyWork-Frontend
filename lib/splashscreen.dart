import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:handywork0/main.dart';


class splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // theme: ThemeData(fontFamily: 'Tajawal'),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash:"assets/images/handywork.png",
        nextScreen: home0(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 3000,
        backgroundColor: Color(0xFFF6F6FA),
        splashIconSize: double.infinity,
      ),

    );

  }
}