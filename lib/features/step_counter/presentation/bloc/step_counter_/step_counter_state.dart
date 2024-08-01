part of 'step_counter_bloc.dart';

abstract class StepCounterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StepCounterInitial extends StepCounterState {}

class StepCounterLoading extends StepCounterState {}

class StepCounterLoaded extends StepCounterState {
  final StepCountClass stepCount;

  StepCounterLoaded({required this.stepCount});

  @override
  List<Object?> get props => [stepCount];
}

class StepCounterError extends StepCounterState {
  final String message;

  StepCounterError({required this.message});

  @override
  List<Object?> get props => [message];
}