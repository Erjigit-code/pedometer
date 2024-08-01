
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/step_count.dart';
import '../repositories/step_counter_repository.dart';


class GetStepCount {
  final StepCounterRepository repository;

  GetStepCount({required this.repository});

  Future<Either<Failure, StepCountClass>> call() async {
    return await repository.getStepCount();
  }
}
