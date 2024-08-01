import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  final double goal;
  final String label;
  final bool isMain;

  ProgressBar({required this.value, required this.goal, required this.label, required this.isMain});

  @override
  Widget build(BuildContext context) {
    double progress = value / goal;

    // Вычисление цели
    String goalText;
    if (label == 'Шаги:') {
      goalText = "Цель: ${goal.toInt()} шагов";
    } else if (label == 'Дистанция (км):') {
      goalText = "Цель: ${goal.toStringAsFixed(2)} км";
    } else {
      goalText = "Цель: ${goal.toStringAsFixed(2)} ккал";
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMain ? 0 : 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularPercentIndicator(
            radius: isMain ? 135.0 : 90.0,  // different sizes for main and side indicators
            lineWidth: isMain ? 9.0 : 5.0, // different line widths for main and side indicators
            animation: false, // Disable animation to avoid restart on each update
            percent: progress.clamp(0.0, 1.0),
            center: Container(), // Empty container to maintain the layout
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Color(0xff3ABBA4),
            backgroundColor: Color(0xff768088), // Make it transparent to show the below layer
          ),
          Container(
            width: isMain ? 280.0 : 180.0, // same size as the CircularPercentIndicator
            height: isMain ? 280.0 : 180.0, // same size as the CircularPercentIndicator
            decoration: BoxDecoration(
              color: Color(0xff494d55), // Your desired background color
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label, style: TextStyle(fontSize: isMain ? 18.0 : 16.0, color: Colors.white)), // different label sizes
                  Text(
                    label == 'Шаги:' ? "${value.toInt()}" : value.toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMain ? 24.0 : 20.0, color: Colors.white), // different text sizes
                  ),
                  SizedBox(height: 30,),
                  Text(goalText, style: TextStyle(fontSize: isMain ? 14.0 : 12.0, color: Colors.white)), // text size for goal
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
