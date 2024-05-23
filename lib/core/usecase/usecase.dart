import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/errors/failures.dart';

abstract interface class UseCase<SucessType, Params>{
 Future<Either<Failure, SucessType>> call(Params params);
}