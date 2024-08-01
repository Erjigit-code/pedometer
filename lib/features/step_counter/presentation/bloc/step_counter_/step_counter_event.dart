part of 'step_counter_bloc.dart';

abstract class StepCounterEvent extends Equatable {
  const StepCounterEvent();

  @override
  List<Object> get props => [];
}

class GetStepCountEvent extends StepCounterEvent {}
class UpdateStepCountEvent extends StepCounterEvent {
  final int steps;

  const UpdateStepCountEvent(this.steps);

  @override
  List<Object> get props => [steps];
}
class TogglePauseEvent extends StepCounterEvent {}
class StartTrackingEvent extends StepCounterEvent {}
class ResetStepCountEvent extends StepCounterEvent {} // Новое событие

class SetStepGoalEvent extends StepCounterEvent {
  final int goal;

  SetStepGoalEvent(this.goal);

  @override
  List<Object> get props => [goal];
}
