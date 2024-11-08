import 'package:flutter/material.dart';
import 'package:weatherapi/models/service.dart';
import 'package:weatherapi/models/weatherModel.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService = Service(apikey: '25d503557341f707ad9f2132773817bd');
  Weather? _weather;

  fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();

    try {
      final fetchedWeather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = fetchedWeather;
      });
    } catch (e) {
      print(e);
    }
  }

  // fetchWeather() async {
  //   String cityName = await weatherService.getCurrentCity();
  //   print("City Name: $cityName");

  //   try {
  //     final fetchedWeather = await weatherService.getWeather(cityName);
  //     print(
  //         "Fetched Weather: ${fetchedWeather.toString()}"); // Add a toString method in Weather class for better output
  //     setState(() {
  //       _weather = fetchedWeather;
  //     });
  //   } catch (e) {
  //     print("Error fetching weather: $e");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city"),
            Text('${_weather?.temperature.round() ?? "Loading tempature"} °C'),
          ],
        ),
      ),
    );
  }
}
