// init_dependencies.dart

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/secrets/app_secrets.dart';
import 'package:weather_app/features/auth/data/remote_data_sources/auth_remote_data_source.dart';
import 'package:weather_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:weather_app/features/auth/domain/repository/auth_repo.dart';
import 'package:weather_app/features/auth/domain/usecases/user_login.dart';
import 'package:weather_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:weather_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:weather_app/features/weather_forecast.dart/data/data_sources/weahter_data_source.dart';
import 'package:weather_app/features/weather_forecast.dart/data/repository/weather_repo_impl.dart';
import 'package:weather_app/features/weather_forecast.dart/domain/usecases/get_weather.dart';
import 'package:weather_app/features/weather_forecast.dart/domain/weather_repo.dart/weather_repo.dart';
import 'package:weather_app/features/weather_forecast.dart/presentation/bloc/weather_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initWeather();
  
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
    supabaseClient: serviceLocator(),
  ));
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
    serviceLocator(),
  ));
  serviceLocator.registerFactory(() => UserSignUp(
    serviceLocator(),
  ));
  serviceLocator.registerFactory(() => UserLogin(
    authRepository: serviceLocator(),
  ));
  serviceLocator.registerLazySingleton(() =>
    AuthBloc(userSignUp: serviceLocator(), userLogin: serviceLocator()));
}

void _initWeather() {
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerFactory<WeatherRemoteDataSource>(() => WeatherRemoteDataSource(
    serviceLocator<Dio>(),
  ));
  serviceLocator.registerFactory<WeatherRepository>(() => WeatherRepositoryImpl(
    remoteDataSource: serviceLocator(),
  ));
  serviceLocator.registerFactory(() => GetWeather(
    serviceLocator(),
  ));
  serviceLocator.registerLazySingleton(() =>
    WeatherBloc(serviceLocator<GetWeather>()));
    
  serviceLocator.registerLazySingleton(() => GeolocatorPlatform.instance);
}
