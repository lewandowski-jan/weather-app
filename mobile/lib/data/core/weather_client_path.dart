import 'package:weatherapp/data/core/secrets.dart';

enum WeatherClientPath {
  current,
  forecast,
  history;

  const WeatherClientPath();

  String get path {
    switch (this) {
      case WeatherClientPath.current:
        return '/v1/current.json';
      case WeatherClientPath.forecast:
        return '/v1/forecast.json';
      case WeatherClientPath.history:
        return '/v1/history.json';
    }
  }

  Uri get baseUri => Uri.https(
        'api.weatherapi.com',
        '',
        <String, dynamic>{
          'key': Secrets.weatherApiKey,
          'aqi': 'no',
        },
      );

  Uri getUri([String? query]) {
    if (query == null) {
      return Uri.https(
        baseUri.authority,
        path,
        baseUri.queryParameters,
      );
    }

    return Uri.https(
      baseUri.authority,
      WeatherClientPath.current.path,
      <String, dynamic>{...baseUri.queryParameters, 'q': query},
    );
  }
}
