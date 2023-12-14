import 'package:weatherapp/data/core/weather_client.dart';
import 'package:weatherapp/data/current/models/current_weather_model.dart';

class CurrentWeatherRepository {
  final WeatherClient client;

  CurrentWeatherRepository({
    required this.client,
  });

  Future<CurrentWeatherModel?> getWeather(String location) async {
    try {
      final model = await client.getCurrent(location);

      return model.current;
    } catch (e) {
      print('EXCEPTION: $e');
    }
  }
}
