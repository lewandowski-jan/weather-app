import 'package:flutter/material.dart';
import 'package:weatherapp/application/core/temperature.dart';
import 'package:weatherapp/presentation/common/gradient_extension.dart';

class Thermometer extends StatelessWidget {
  final Temperature temperature;

  const Thermometer({
    super.key,
    required this.temperature,
  });

  static const Temperature _minTemperature = Temperature(
    value: -12,
    unit: TemperatureUnit.celsius,
  );

  static const Temperature _maxTemperature = Temperature(
    value: 36,
    unit: TemperatureUnit.celsius,
  );

  static const LinearGradient _colorGradient = LinearGradient(
    stops: [
      0.1,
      0.2,
      0.4,
      0.6,
      0.9,
    ],
    colors: [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.lightBlue,
      Colors.blue,
    ],
  );

  Color _getColor(Temperature temperature) {
    final value = temperature.value;
    final minValue = _minTemperature.value;
    final maxValue = _maxTemperature.value;
    final range = maxValue - minValue;

    return _colorGradient.colorAt(
      (maxValue - value) / range,
    )!;
  }

  double _getHeightFactor(Temperature temperature) {
    final value = temperature.value;
    final minValue = _minTemperature.value;
    final maxValue = _maxTemperature.value;
    final range = maxValue - minValue;

    return 1 - (maxValue - value) / range;
  }

  @override
  Widget build(BuildContext context) {
    final heightFactor = _getHeightFactor(temperature);
    final color = _getColor(temperature);

    return Center(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 400,
            child: AnimatedContainer(
              clipBehavior: Clip.none,
              height: (heightFactor * 400).clamp(50, 400),
              alignment: Alignment.topCenter,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: TemperatureLabel(temperature: temperature),
            ),
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AnimatedContainer(
                  width: 100,
                  height: heightFactor * 400,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: const ShapeDecoration(
                    color: Colors.transparent,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                  ),
                  width: 100,
                  height: 400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TemperatureLabel extends StatelessWidget {
  final Temperature temperature;

  const TemperatureLabel({
    super.key,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Text(
            temperature.value.toString(),
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            temperature.unit.toString(),
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
