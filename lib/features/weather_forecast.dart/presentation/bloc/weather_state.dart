part of 'weather_bloc.dart';


@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherSuccessState extends WeatherState {
  final Weather weather;

  WeatherSuccessState(this.weather);
}
final class WeatherLoading extends WeatherState {}
final class WeatherFailure extends WeatherState {
  final String message;
  WeatherFailure({required this.message});
}
