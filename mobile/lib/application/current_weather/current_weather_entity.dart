import 'package:weatherapp/application/core/temperature_value_object.dart';
import 'package:weatherapp/data/current/models/current_weather_model.dart';

class CurrentWeatherEntity {
  final TemperatureValueObject temperatureC;
  final TemperatureValueObject temperatureF;

  CurrentWeatherEntity({
    required this.temperatureC,
    required this.temperatureF,
  });

  static CurrentWeatherEntity fromModel(CurrentWeatherModel model) {
    return CurrentWeatherEntity(
      temperatureC: TemperatureValueObject(
        unit: TemperatureUnit.celsius,
        value: model.temperatureCelsius,
      ),
      temperatureF: TemperatureValueObject(
        unit: TemperatureUnit.fahrenheit,
        value: model.temperatureFahrenheit,
      ),
    );
  }
}
