import '../../domain/entities/step_count.dart';

class StepCountModel extends StepCountClass {
  StepCountModel({required int steps, required int goal})
      : super(steps: steps, goal: goal);

  factory StepCountModel.fromJson(Map<String, dynamic> json) {
    return StepCountModel(
      steps: json['steps'],
      goal: json['goal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'steps': steps,
      'goal': goal,
    };
  }
}
