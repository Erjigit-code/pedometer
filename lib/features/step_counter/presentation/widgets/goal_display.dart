import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/step_counter_/step_counter_bloc.dart';

class GoalDisplay extends StatefulWidget {
  final bool isEditing;
  final TextEditingController goalController;

  GoalDisplay({required this.isEditing, required this.goalController});

  @override
  _GoalDisplayState createState() => _GoalDisplayState();
}

class _GoalDisplayState extends State<GoalDisplay> {
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.isEditing;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepCounterBloc, StepCounterState>(
      builder: (context, state) {
        if (state is StepCounterLoaded) {
          return GestureDetector(
            child: Container(
              width: 350,
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff3ABBA4),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isEditing
                      ? Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        final goal = int.tryParse(widget.goalController.text);
                        if (goal != null) {
                          BlocProvider.of<StepCounterBloc>(context).add(SetStepGoalEvent(goal));
                        }
                        setState(() {
                          _isEditing = !_isEditing;
                        });
                      },
                      controller: widget.goalController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white, fontSize: 26),
                      decoration: InputDecoration(
                        hintText: 'Введите вашу цель',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                      : Expanded(
                    child: Text(
                      'Цель: ${state.stepCount.goal} шагов',
                      style: TextStyle(color: Colors.white, fontSize: 26),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isEditing ? Icons.check : Icons.edit, color: Colors.white),
                    onPressed: () {
                      if (_isEditing) {
                        final goal = int.tryParse(widget.goalController.text);
                        if (goal != null) {
                          BlocProvider.of<StepCounterBloc>(context).add(SetStepGoalEvent(goal));
                        }
                      }
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                  ),
                ],
              ),
            ),
            onTap: () {
              if (_isEditing) {
                final goal = int.tryParse(widget.goalController.text);
                if (goal != null) {
                  BlocProvider.of<StepCounterBloc>(context).add(SetStepGoalEvent(goal));
                }
              }
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
