import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:simpleweatherapp/Provider/provider.dart';
import 'package:simpleweatherapp/Pages/weather_page.dart';

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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UIprovider>(
      builder: (context, UIprovider notifier, child) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: notifier.isdark ? ThemeMode.light : ThemeMode.dark,
          home: const WeatherPage(),
        );
      },
    );
  }
}
