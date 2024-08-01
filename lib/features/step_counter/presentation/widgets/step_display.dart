import 'package:flutter/material.dart';

class StepDisplay extends StatelessWidget {
  final int steps;

  StepDisplay({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        'Шаги: $steps',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
