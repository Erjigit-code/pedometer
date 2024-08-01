import 'package:flutter/material.dart';

class WalkingTimeDisplay extends StatelessWidget {
  // For simplicity, we'll assume walking speed is 5 km/h
  final double walkingSpeed = 5.0; // km/h

  @override
  Widget build(BuildContext context) {
    // In a real app, you'd calculate this based on actual step data
    double walkingTime = (/* total distance */ 0.0) / walkingSpeed;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        'Время ходьбы: ${walkingTime.toStringAsFixed(2)} часов',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
