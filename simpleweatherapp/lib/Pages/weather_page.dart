import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

  String getWeatherAnimation(String? mainCondition) {
    //default null anim
    if (mainCondition == null) return 'assets/error.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloudy.json';
      case 'mist':
        return 'assets/cloudy.json';
      case 'smoke':
        return 'assets/cloudy.json';
      // case 'haze':
      //   return 'assets/.json';
      case 'dust':
        return 'assets/Snow.json';
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
        return 'assets/raining.json';
      // case 'drizzle':
      //   return 'assets/.json';
      case 'shower rain':
        return 'assets/raining.json';
      case 'thunderstorm':
        return 'assets/Storm.json';
      case 'clear':
        return 'assets/Sunny.json';
      default:
        return 'assets/Sunny.json';
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
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                _weather?.city ?? "Lemme see where da fuq are you",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            //temp
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _weather?.mainCondition ?? "Unlucky",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 80, bottom: 50, left: 20, right: 20),
              child: Text(
                '${_weather?.temperature.round()}°C',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 100,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
