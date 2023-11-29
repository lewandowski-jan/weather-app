import 'package:http/http.dart';
import 'package:weatherapp/data/core/base_client.dart';
import 'package:weatherapp/data/core/weather_client_path.dart';
import 'package:weatherapp/data/current/models/current.dart';

class WeatherClient extends WABaseClient {
  Future<Current> getCurrent(String location) async {
    final response = await get(WeatherClientPath.current.getUri(location));

    return Current.fromJson(response.body);
  }

  Future<void> getForecast() async {
    final response = await get(WeatherClientPath.forecast.getUri());

    return;
  }
}
