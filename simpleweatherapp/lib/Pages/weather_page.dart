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
  final _weatherService = WeartherServices('2a6c023cdd0b33bc3de807e41783c6f5');

  //weather object
  Weather? _weather;

  //get the weather
  fetchWeather() async {
    //locate city
    String name = await _weatherService.getCurrentCity();

    //get the weather after locatin the city
    try {
      final weather = await _weatherService.getWeather(name);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //init weather
  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.city ?? "Lemme see where da fuq are you"),
            //temp
            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}
