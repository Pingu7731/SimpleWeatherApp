import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:simpleweatherapp/models/weather_models.dart';

class WeartherServices {
  static const base_url = 'apikey';
  final String apiKey;

  WeartherServices(this.apiKey);

  Future<Weather> getWeather(String city) async {
    //let the app know what weather you having
    final response = await http.get(
      Uri.parse(
        '$base_url?q=$city&appid=#$apiKey&units=metric',
      ),
    );
    if (response.statusCode == 200) {
      return Weather.fromJson(
          jsonDecode(response.body)); //decode information from website
    } else {
      throw Exception('Where the fuq are you');
    }
  }

  Future<String> getCurrentCity() async {
    //check user permission for location from geolocator
    LocationPermission permission = await Geolocator.checkPermission();

    //request permission
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //location accuracy
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality; //get city name

    return city ?? "";
  }
}
