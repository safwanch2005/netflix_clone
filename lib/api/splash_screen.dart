import 'package:flutter/material.dart';
import 'package:netflix_clone/bottom_navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNavigation(), 
        ),
      );
    });

    return Scaffold(
  body: Center(
    child: Image.asset(
      "images/netfologo.png",
      width: 200,
      height: 200,
    ),
  ),
);
  }
}