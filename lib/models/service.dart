import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weatherapi/models/weatherModel.dart';

class Service {
  static const URL = 'https://api.openweathermap.org/data/2.5/weather';
  // static const URL =
  //   'https://api.openweathermap.org/data/2.5/weather?id=2172797&appid={25d503557341f707ad9f2132773817bd}';

  final String apikey;

  Service({required this.apikey});

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$URL?q=$cityName&appid=$apikey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unable to load data.');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;
    return city ?? "";
  }
}
