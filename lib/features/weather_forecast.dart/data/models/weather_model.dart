import 'package:weather_app/features/weather_forecast.dart/domain/entities/weather_entity.dart';

class WeatherModel {
  final String cityName;
  final String description;
  final String icon;
  final double temperature;
  final double maxTemp;

  WeatherModel({
    required this.cityName,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.maxTemp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? 'Unknown Location',
      description: json['weather'][0]['description'] ?? 'No description',
      icon: json['weather'][0]['icon'] ?? '',
      temperature: _convertKelvinToCelsius(json['main']['temp'] as num?),
      maxTemp: _convertKelvinToCelsius(json['main']['temp_max'] as num?),
    );
  }

  static double _convertKelvinToCelsius(num? kelvin) {
    if (kelvin == null) return 0.0;
    return kelvin.toDouble() - 273.15;
  }

  Weather toEntity() {
    return Weather(
      cityName: cityName,
      temperature: temperature,
      icon: icon,
      maxTemp: maxTemp,
      description: description,
    );
  }
}
