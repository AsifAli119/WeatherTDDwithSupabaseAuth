 import 'package:weather_app/features/weather_forecast.dart/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(double latitude, double longitude);
}