// ignore_for_file: unused_element, unnecessary_new, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:testerr/login/login.dart';
import 'dart:async';

import 'package:testerr/theme.dart';

class Splashpage extends StatefulWidget {
  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  Timer _timer;

  _SplashpageState() {
    _timer = new Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/logo.png'))),
            )),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Masjid At-Taqwa",
                style: regularTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
