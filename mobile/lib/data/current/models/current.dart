import 'dart:convert';

import 'package:weatherapp/data/current/models/current_weather_model.dart';
import 'package:weatherapp/data/current/models/location.dart';

class Current {
  final Location location;
  final CurrentWeatherModel current;

  Current({
    required this.location,
    required this.current,
  });

  Current copyWith({
    Location? location,
    CurrentWeatherModel? current,
  }) {
    return Current(
      location: location ?? this.location,
      current: current ?? this.current,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location.toMap(),
      'current': current.toMap(),
    };
  }

  factory Current.fromMap(Map<String, dynamic> map) {
    return Current(
      location: Location.fromMap(map['location']),
      current: CurrentWeatherModel.fromMap(map['current']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Current.fromJson(String source) =>
      Current.fromMap(json.decode(source));

  @override
  String toString() => 'Current(location: $location, current: $current)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Current &&
        other.location == location &&
        other.current == current;
  }

  @override
  int get hashCode => location.hashCode ^ current.hashCode;
}
