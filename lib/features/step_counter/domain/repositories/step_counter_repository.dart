
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/step_count.dart';


abstract class StepCounterRepository {
  Future<Either<Failure, StepCountClass>> getStepCount();

  Future<Either<Failure, void>> setStepGoal(int goal); // Новый метод
}
