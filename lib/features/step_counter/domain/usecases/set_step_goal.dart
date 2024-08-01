import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/step_counter_repository.dart';

class SetStepGoal {
  final StepCounterRepository repository;

  SetStepGoal(this.repository);

  Future<Either<Failure, void>> call(int goal) async {
    return await repository.setStepGoal(goal);
  }
}
