import 'package:flutter/material.dart';
import 'package:flutter_mona/Screen/homescreen.dart';
import 'package:flutter_mona/Screen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/dash': (context) => const HomeScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
