import 'package:flutter/material.dart';
import 'package:simpleweatherapp/Pages/weather_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: WeatherPage(),
    );
  }
}
