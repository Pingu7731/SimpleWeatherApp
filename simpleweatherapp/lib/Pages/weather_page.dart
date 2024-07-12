import 'package:flutter/material.dart';

import 'package:simpleweatherapp/models/weather_models.dart';
import 'package:simpleweatherapp/services/wearther_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeartherServices("apiKey");

  //weather object
  Weather? _weather;

  //get the weather
  fetchWeather() async {
    //locate city
    String name = await _weatherService.getCurrentCity();

    //get the weather after locatin the city
    try {
      final userWeather = await _weatherService.getWeather(name);
    } catch (e) {
      print(e);
    }
    //init weather
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 164, 250),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.city ?? "Locating..."),
            //temp
            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}
