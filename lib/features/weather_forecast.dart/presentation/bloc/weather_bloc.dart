import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather_forecast.dart/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather_forecast.dart/domain/usecases/get_weather.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;
  WeatherBloc(this.getWeather) : super(WeatherInitial()) {
    on<WeatherFetchEvent>(_weatherFetchEvent);
  }

  FutureOr<void> _weatherFetchEvent(WeatherFetchEvent event, Emitter<WeatherState> emit) async {
      emit(WeatherLoading());
      try {
        final weather = await getWeather.execute(event.longitude, event.latitude);
        emit(WeatherSuccessState(weather));
      } catch (e) {
        emit(WeatherFailure(message: e.toString()));
      }
  }
}
