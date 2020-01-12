import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather/ui/home.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startsSplash();
  }

  startsSplash() async {
    return Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return MyHomePage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6CC4D3),
      body: Center(
        child: Image.asset(
          'assets/img/weather_icons.png',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
