import 'package:equatable/equatable.dart';

class StepCountClass extends Equatable {
  final int steps;
  final int goal;

  StepCountClass({required this.steps, required this.goal});

  @override
  List<Object> get props => [steps, goal];
}
