import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedometer_app_new_version/features/step_counter/presentation/pages/step_counter_content/widgets/activity_chart.dart';
import '../../bloc/step_counter_/step_counter_bloc.dart';
import '../../widgets/progress_bar.dart';
import '../../widgets/pause_button.dart';
import '../../widgets/distance_display.dart';
import '../../widgets/calories_display.dart';
import '../../widgets/walking_time_display.dart';

class StepCounterContent extends StatefulWidget {
  final PageController pageController;
  final int currentPage;

  StepCounterContent({required this.pageController, required this.currentPage});

  @override
  _StepCounterContentState createState() => _StepCounterContentState();
}

class _StepCounterContentState extends State<StepCounterContent> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentPage;
    widget.pageController.addListener(() {
      setState(() {
        _currentPage = widget.pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepCounterBloc, StepCounterState>(
      builder: (context, state) {
        if (state is StepCounterLoaded) {
          double distance = state.stepCount.steps * 0.0008; // Approximation: 1 step ~ 0.8 meters
          double calories = state.stepCount.steps * 0.04; // Approximation: 1 step ~ 0.04 calories
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300, // Задайте высоту для PageView
                  child: PageView.builder(
                    itemCount: 3,
                    controller: widget.pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      bool isMain = index == _currentPage;
                      if (index == 0) {
                        return ProgressBar(
                          value: distance,
                          goal: state.stepCount.goal * 0.0008,
                          label: 'Дистанция (км):',
                          isMain: isMain,
                        );
                      } else if (index == 1) {
                        return ProgressBar(
                          value: state.stepCount.steps.toDouble(),
                          goal: state.stepCount.goal.toDouble(),
                          label: 'Шаги:',
                          isMain: isMain,
                        );
                      } else {
                        return ProgressBar(
                          value: calories,
                          goal: state.stepCount.goal * 0.04,
                          label: 'Калории (ккал):',
                          isMain: isMain,
                        );
                      }
                    },
                  ),
                ),
                PauseButton(),
                DistanceDisplay(distance: distance),
                CaloriesDisplay(calories: calories),
                WalkingTimeDisplay(),
                ActivityChart(),
              ],
            ),
          );
        } else if (state is StepCounterError) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(child: Text(state.message)),
                PauseButton(),
                DistanceDisplay(distance: 0.0), // Предположим, что шагов нет при ошибке
                CaloriesDisplay(calories: 0.0), // Предположим, что калорий нет при ошибке
                WalkingTimeDisplay(), // Предположим, что времени нет при ошибке
              ],
            ),
          );
        } else {
          return Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Нажмите на кнопку, чтобы начать считать шаги', style: TextStyle(fontSize: 15, color :Colors.white),),
SizedBox(height: 80,),
              DistanceDisplay(distance: 0.0), // Предположим, что шагов нет до начала отсчета
              CaloriesDisplay(calories: 0.0), // Предположим, что калорий нет до начала отсчета
              WalkingTimeDisplay(), // Предположим, что времени нет до начала отсчета
            ],
          );
        }
      },
    );
  }
}
