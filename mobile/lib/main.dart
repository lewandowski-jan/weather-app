// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/application/core/temperature_value_object.dart';
import 'package:weatherapp/application/current_weather/current_weather_bloc.dart';
import 'package:weatherapp/application/current_weather/current_weather_entity.dart';
import 'package:weatherapp/data/core/weather_client.dart';
import 'package:weatherapp/data/current/current_weather_repository.dart';
import 'package:weatherapp/data/current/models/current.dart';
import 'package:weatherapp/presentation/common/thermometer.dart';

void main() async {
  runApp(
    Provider(
      create: (context) => WeatherClient(),
      child: Provider(
        create: (context) => CurrentWeatherRepository(
          client: context.read<WeatherClient>(),
        ),
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  CurrentWeatherEntity? getWeather({required CurrentWeatherState from}) {
    final state = from;

    if (state is CurrentWeatherLoading) {
      return state.lastWeather;
    }

    if (state is CurrentWeatherLoaded) {
      return state.weather;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();

    return BlocProvider(
      create: (context) => CurrentWeatherBloc(
        repository: context.read<CurrentWeatherRepository>(),
      ),
      child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
          builder: (context, state) {
        final weather = getWeather(from: state);

        return MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: AppBar(),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              final location = textEditingController.text;

                              context.read<CurrentWeatherBloc>().add(
                                    QueryForLocationEvent(location: location),
                                  );
                            },
                            icon: const Icon(Icons.search),
                          )
                        ],
                      ),
                      const SizedBox(height: 100),
                      Thermometer(
                        temperature: weather?.temperatureC ??
                            const TemperatureValueObject(
                              value: 0,
                              unit: TemperatureUnit.celsius,
                            ),
                      ),
                    ],
                  ),
                ),
                if (state is CurrentWeatherLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        );
      }),
    );
  }
}
