import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/auth/domain/entities/user.dart';
import 'package:weather_app/features/auth/domain/repository/auth_repo.dart';

class UserSignUp implements UseCase<User, UserSignUpPramas> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpPramas params) async {
    return await authRepository.signUpWithEmailPassword(
        name: params.name, 
        email: params.email, 
        password: params.password,
        );
  }
}

class UserSignUpPramas {
  final String name;
  final String email;
  final String password;

  UserSignUpPramas({
    required this.name,
    required this.email,
    required this.password,
  });
}
