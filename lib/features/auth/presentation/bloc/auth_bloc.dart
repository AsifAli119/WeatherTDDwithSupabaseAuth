import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/domain/entities/user.dart';
import 'package:weather_app/features/auth/domain/usecases/user_login.dart';
import 'package:weather_app/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_authLogin);
  }

  FutureOr<void> _onAuthSignUp(
      AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpPramas(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold((error) => emit(AuthFailure(message: error.message)),
        (user) => emit(AuthSuccess(user: user)));
  }

  FutureOr<void> _authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    res.fold((error) => emit(AuthFailure(message: error.message)),
        (user) => emit(AuthSuccess(user: user)));
  }
}
