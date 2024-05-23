import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name, required String email, required String password});




  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password});

}