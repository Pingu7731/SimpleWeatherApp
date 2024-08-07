import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:simpleweatherapp/Provider/provider.dart';
import 'package:simpleweatherapp/models/weather_models.dart';
import 'package:simpleweatherapp/services/wearther_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeartherServices('${dotenv.env['api']}');
  Weather? _weather;

  Future<void> fetchWeather() async {
    String name = await _weatherService.getCurrentCity();
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
    if (mainCondition == null) return 'assets/error.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'fog':
        return 'assets/cloudy.json';
      case 'dust':
        return 'assets/Snow.json';
      case 'rain':
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

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      body: RefreshIndicator(
        onRefresh: fetchWeather,
        child: ListView(
          children: [
            //i added something here to chang the bg
            Consumer<UIprovider>(
              builder: (context, UIprovider notifier, child) {
                return ListTile(
                  leading: const Icon(Icons.dark_mode),
                  trailing: Switch(
                    value: notifier.isdark,
                    onChanged: notifier.changeTheme,
                  ),
                );
              },
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
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
          ],
        ),
      ),
    );
  }
}
