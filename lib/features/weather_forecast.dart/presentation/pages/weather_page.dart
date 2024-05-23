import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/core/utilis/weather_utilils.dart';
import 'package:weather_app/features/weather_forecast.dart/presentation/bloc/weather_bloc.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      context.read<WeatherBloc>().add(WeatherFetchEvent(
            position.longitude,
            position.latitude,
          ));
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Align(
              alignment: const AlignmentDirectional(10, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPallete.gradient3,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-10, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPallete.gradient1,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.2),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  color: AppPallete.gradient2,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WeatherSuccessState) {
                  return _buildWeatherContent(state);
                } else if (state is WeatherFailure) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Failed to load weather'),
                      ElevatedButton(
                          onPressed: () {
                            _fetchWeather();
                          },
                          child: const Text('Refersh'))
                    ],
                  ));
                } else {
                  return const Center(child: Text('Please wait...'));
                }
              },
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildWeatherContent(WeatherSuccessState state) {
    String greeting = WeatherUtils.getGreetingMessage();
    DateTime now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(state.weather.cityName),
        const SizedBox(height: 8),
        Text(
          greeting,
          style: const TextStyle(
            color: AppPallete.whiteColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Center(
          child: Image(
            height: 200,
            image: NetworkImage(
              'https://openweathermap.org/img/wn/${state.weather.icon}@2x.png',
            ),
          ),
        ),
        Center(
          child: Text(
            '${state.weather.temperature.toStringAsFixed(1)} °C',
            style: const TextStyle(
              color: AppPallete.whiteColor,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            state.weather.description.toUpperCase(),
            style: const TextStyle(
              color: AppPallete.whiteColor,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Center(
          child: Text(
            DateFormat('EEE d, HH:mm').format(now), 

            style: const TextStyle(
              color: Color.fromARGB(255, 214, 191, 191),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Table(
            defaultColumnWidth: const FixedColumnWidth(130.0),
            border: TableBorder.all(
              color: Colors.grey,
              style: BorderStyle.solid,
              width: 1,
            ),
            children: [
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Temp Max',
                        style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        state.weather.maxTemp.toStringAsFixed(1).trim(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
