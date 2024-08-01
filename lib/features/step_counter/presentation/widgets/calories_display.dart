import 'package:flutter/material.dart';

class CaloriesDisplay extends StatelessWidget {
  final double calories;

  CaloriesDisplay({required this.calories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        'Калории: ${calories.toStringAsFixed(2)} ккал',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
