import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:weather_app/core/secrets/weather_urls/urls.dart';
import '../models/weather_model.dart';

class WeatherRemoteDataSource {
  final Dio client;


  WeatherRemoteDataSource(this.client);

  Future<WeatherModel> getWeather(double latitude, double longitude) async {
    try {
      log('Fetching weather data for lat: $latitude, lon: $longitude');
      final response = await client.get(
        '${ApiConstants.baseUrl}weather',
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'appid': ApiConstants.apiKey,
        },
      );

      log('Received response: ${response.data}');
      if (response.statusCode == 200) {
        log('Weather data fetched successfully');
        return WeatherModel.fromJson(response.data);
      } else {
        log('Failed to load weather: ${response.statusMessage}');
        throw Exception('Failed to load weather');
      }
    } catch (e, stacktrace) {
      log('Exception occurred while fetching weather data: $e',  stackTrace: stacktrace);
      throw Exception('Failed to load weather');
    }
  }
}
