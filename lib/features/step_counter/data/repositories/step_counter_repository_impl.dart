import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/step_count.dart';
import '../../domain/repositories/step_counter_repository.dart';
import '../../domain/usecases/set_step_goal.dart';

import '../datasources/step_counter_local_data_source.dart';
import '../../../../core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class StepCounterRepositoryImpl implements StepCounterRepository {
  final StepCounterLocalDataSource localDataSource;

  StepCounterRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, StepCountClass>> getStepCount() async {
    try {
      final localStepCount = await localDataSource.getLastStepGoal();
      return Right(localStepCount);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setStepGoal(int goal) async {
    try {
      await localDataSource.setStepGoal(goal);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
