import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mona/Screen/homescreen.dart';
import 'package:flutter_mona/Screen/onboardingscreen.dart';
import 'package:flutter_mona/constants/color_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 1), () {
      validator();
    });
  }

  void validator() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (localStorage.getString('api_token') == null &&
        localStorage.getString('id') == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SliderPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  )),
            ],
          )),
        ),
      ),
    );
  }
}
