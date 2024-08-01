import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/step_counter_/step_counter_bloc.dart';


class PauseButton extends StatefulWidget {
  @override
  _PauseButtonState createState() => _PauseButtonState();
}

class _PauseButtonState extends State<PauseButton> {
  bool _isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Container(width: 150,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isPaused = !_isPaused;
          });
          BlocProvider.of<StepCounterBloc>(context).add(TogglePauseEvent());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isPaused ? Colors.red : Color(0xff3ABBA4),
        ),
        child: Text(_isPaused ? 'Продолжить' : 'Пауза', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
