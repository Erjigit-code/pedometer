import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/step_count.dart';

abstract class StepCounterLocalDataSource {
  Future<StepCountClass> getLastStepGoal();
  Future<void> setStepGoal(int goal);
}

class StepCounterLocalDataSourceImpl implements StepCounterLocalDataSource {
  final SharedPreferences sharedPreferences;

  StepCounterLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<StepCountClass> getLastStepGoal() async {
    try {
      final stepGoal = sharedPreferences.getInt('STEP_GOAL_KEY') ?? 7000;
      print("Retrieved from SharedPreferences - stepGoal: $stepGoal");
      return StepCountClass(steps: 0, goal: stepGoal); // шаги всегда 0, так как они берутся из pedometer
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> setStepGoal(int goal) async {
    await sharedPreferences.setInt('STEP_GOAL_KEY', goal);
    print("Step goal set in SharedPreferences: $goal");
  }
}
