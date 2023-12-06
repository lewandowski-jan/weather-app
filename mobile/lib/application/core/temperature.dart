enum TemperatureUnit {
  celsius,
  fahrenheit;

  const TemperatureUnit();

  @override
  String toString() => switch (this) {
        TemperatureUnit.celsius => '°C',
        TemperatureUnit.fahrenheit => '°F',
      };
}

class Temperature {
  final double value;
  final TemperatureUnit unit;

  const Temperature({
    required this.value,
    required this.unit,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Temperature && other.value == value && other.unit == unit;
  }

  @override
  int get hashCode => value.hashCode ^ unit.hashCode;
}
