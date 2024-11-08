import 'package:flutter/material.dart';
import 'package:weatherapi/pages/weatherpage.dart';

void main() {
  runApp(const MyApp());
}

// 25d503557341f707ad9f2132773817bd
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
