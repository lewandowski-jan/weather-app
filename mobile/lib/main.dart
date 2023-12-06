// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:weatherapp/application/core/temperature.dart';
import 'package:weatherapp/data/core/weather_client.dart';
import 'package:weatherapp/presentation/common/thermometer.dart';

void main() async {
  // final currentWeather = await WeatherClient().getCurrent('Warsaw');
  // print(currentWeather);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Thermometer(
            temperature: Temperature(
              value: 10,
              unit: TemperatureUnit.celsius,
            ),
          ),
        ),
      ),
    );
  }
}
