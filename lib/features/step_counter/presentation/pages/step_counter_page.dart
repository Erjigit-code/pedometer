import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedometer_app_new_version/features/step_counter/presentation/pages/step_counter_content/step_counter_content.dart';
import 'package:pedometer_app_new_version/features/step_counter/presentation/pages/step_counter_content/widgets/activity_chart.dart';
import '../bloc/step_counter_/step_counter_bloc.dart';
import '../widgets/goal_display.dart';


class StepCounterPage extends StatefulWidget {
  @override
  _StepCounterPageState createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  final TextEditingController _goalController = TextEditingController();
  final PageController _pageController = PageController(viewportFraction: 0.58);
  int _currentPage = 0;
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Верхняя часть с изображением 1
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/image1.jpg",
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Нижняя часть с цветом 0xff242426
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height / 2,
            child: Container(
              color: Color(0xff242426),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 30,),
                GoalDisplay(
                  isEditing: _isEditing,
                  goalController: _goalController,
                ),
                Expanded(
                  child: StepCounterContent(
                    pageController: _pageController,
                    currentPage: _currentPage,
                  ),
                ),
                // Добавляем новый виджет ActivityChart

              ],
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<StepCounterBloc, StepCounterState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<StepCounterBloc>(context);
          if (!bloc.isStarted) {
            return FloatingActionButton(
              onPressed: () {
                bloc.add(StartTrackingEvent());
              },
              child: Icon(Icons.directions_walk),
            );
          }
          return Container(); // Возвращаем пустой контейнер, чтобы скрыть кнопку
        },
      ),
    );
  }
}
