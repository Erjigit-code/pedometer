import 'package:flutter/material.dart';

class DistanceDisplay extends StatelessWidget {
  final double distance;

  DistanceDisplay({required this.distance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        'Дистанция: ${distance.toStringAsFixed(2)} км',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
