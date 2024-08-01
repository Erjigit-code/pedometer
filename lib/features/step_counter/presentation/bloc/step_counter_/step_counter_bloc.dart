import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pedometer/pedometer.dart';
import '../../../domain/entities/step_count.dart';
import '../../../domain/usecases/get_step_count.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../domain/usecases/set_step_goal.dart';

part 'step_counter_event.dart';
part 'step_counter_state.dart';

class StepCounterBloc extends Bloc<StepCounterEvent, StepCounterState> {
  final GetStepCount getStepCount;
  final SharedPreferences sharedPreferences;

  final SetStepGoal setStepGoal; // Новый use case
  StreamSubscription<StepCount>? _stepCountSubscription;
  bool _isPaused = false;
  bool _isStarted = false;
  int _initialSteps = 0;

  StepCounterBloc({
    required this.getStepCount,
    required this.sharedPreferences
  , required this.setStepGoal
  }) : super(StepCounterInitial()) {
    on<GetStepCountEvent>(_onGetStepCountEvent);
    on<UpdateStepCountEvent>(_onUpdateStepCountEvent);
    on<TogglePauseEvent>(_onTogglePauseEvent);
    on<StartTrackingEvent>(_onStartTrackingEvent);
    _loadInitialData();
    on<SetStepGoalEvent>(_onSetStepGoalEvent);
  }

  bool get isStarted => _isStarted;

  void _loadInitialData() async {
    _isStarted = sharedPreferences.getBool('isStarted') ?? false;
    _initialSteps = sharedPreferences.getInt('initial_steps') ?? 0;
    if (_isStarted) {
      add(GetStepCountEvent());
      _startListeningStepCount();
    }
  }

  void _startListeningStepCount() {
    _stepCountSubscription = Pedometer.stepCountStream.listen(
          (StepCount stepCount) {
        if (!_isPaused) {
          add(UpdateStepCountEvent(stepCount.steps));
        }
      },
      onError: (error) => print("Error from pedometer: $error"),
    );
  }

  void _onGetStepCountEvent(GetStepCountEvent event, Emitter<StepCounterState> emit) async {
    emit(StepCounterLoading());
    final result = await getStepCount();
    result.fold(
          (failure) => emit(StepCounterError(message: 'Failed to get step count')),
          (stepCount) {
        print("Loaded goal from SharedPreferences: ${stepCount.goal}");
        emit(StepCounterLoaded(stepCount: stepCount));
      },
    );
  }

  void _onUpdateStepCountEvent(UpdateStepCountEvent event, Emitter<StepCounterState> emit) {
    if (state is StepCounterLoaded) {
      final currentState = state as StepCounterLoaded;
      final adjustedSteps = event.steps - _initialSteps;
      final nonNegativeSteps = adjustedSteps < 0 ? 0 : adjustedSteps; // Коррекция отрицательных шагов
      print("Adjusted steps: $nonNegativeSteps (Received steps: ${event.steps}, Initial steps: $_initialSteps)");
      emit(StepCounterLoaded(stepCount: StepCountClass(steps: nonNegativeSteps, goal: currentState.stepCount.goal)));
    }
  }

  void _onTogglePauseEvent(TogglePauseEvent event, Emitter<StepCounterState> emit) {
    _isPaused = !_isPaused;
  }

  void _onStartTrackingEvent(StartTrackingEvent event, Emitter<StepCounterState> emit) async {
    final status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      _isStarted = true;
      sharedPreferences.setBool('isStarted', true);
      final steps = await Pedometer.stepCountStream.first;
      _initialSteps = steps.steps;

      add(GetStepCountEvent());
      _startListeningStepCount();
    } else if (status.isDenied) {
      emit(StepCounterError(message: 'Permission denied'));
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }


  void _onSetStepGoalEvent(SetStepGoalEvent event, Emitter<StepCounterState> emit) async {
    final result = await setStepGoal(event.goal);
    result.fold(
          (failure) => emit(StepCounterError(message: 'Failed to set step goal')),
          (_) {
        if (state is StepCounterLoaded) {
          final currentState = state as StepCounterLoaded;
          final updatedStepCount = StepCountClass(steps: currentState.stepCount.steps, goal: event.goal);
          emit(StepCounterLoaded(stepCount: updatedStepCount));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _stepCountSubscription?.cancel();
    return super.close();
  }
}