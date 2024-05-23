
import 'package:weather_app/features/weather_forecast.dart/data/data_sources/weahter_data_source.dart';
import 'package:weather_app/features/weather_forecast.dart/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather_forecast.dart/domain/weather_repo.dart/weather_repo.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Weather> getWeather(double latitude, double longitude) async {
    final weatherModel = await remoteDataSource.getWeather(latitude, longitude);
    return weatherModel.toEntity();
  }
}