import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/auth/domain/entities/user.dart';
import 'package:weather_app/features/auth/domain/repository/auth_repo.dart';

class UserLogin implements UseCase<User, UserLoginParams>{
  final AuthRepository authRepository;

  UserLogin({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
      return await authRepository.loginWithEmailPassword(email: params.email, password: params.password);
  }
}



class UserLoginParams{
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}