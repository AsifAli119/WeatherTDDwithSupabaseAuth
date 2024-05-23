
import 'package:weather_app/features/weather_forecast.dart/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather_forecast.dart/domain/weather_repo.dart/weather_repo.dart';


class GetWeather {
  final WeatherRepository repository;

  GetWeather(this.repository);

  Future<Weather> execute(double latitude, double longitude) {
    return repository.getWeather(latitude, longitude);
  }
}
