import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:simpleweatherapp/Provider/provider.dart';
import 'package:simpleweatherapp/pages/weather_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (context) => UIprovider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UIprovider>(
      builder: (context, UIprovider notifier, child) {
        return MaterialApp(
          //is this not the change theme bg thing ? XD
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: notifier.isdark ? ThemeMode.light : ThemeMode.dark,
          home: const WeatherPage(),
        );
      },
    );
  }
}
