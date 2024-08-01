import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActivityChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xff242426),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Активность',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Text('Неделя', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Месяц', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          AspectRatio(
            aspectRatio: 2,
            child: LineChart(
              LineChartData(
                backgroundColor: Color(0xff242426),
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[800],
                      strokeWidth: 1,
                    );
                  },
                  drawVerticalLine: true,
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey[800],
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 22,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0:
                            return Text('ПН', style: TextStyle(color: Colors.white));
                          case 1:
                            return Text('ВТ', style: TextStyle(color: Colors.white));
                          case 2:
                            return Text('СР', style: TextStyle(color: Colors.white));
                          case 3:
                            return Text('ЧТ', style: TextStyle(color: Colors.white));
                          case 4:
                            return Text('ПТ', style: TextStyle(color: Colors.white));
                          case 5:
                            return Text('СБ', style: TextStyle(color: Colors.white));
                          case 6:
                            return Text('ВС', style: TextStyle(color: Colors.white));
                        }
                        return Container();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (value, meta) {
                        return Text('${value.toInt()} км', style: TextStyle(color: Colors.white));
                      },
                      reservedSize: 32,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey[800]!, width: 1),
                ),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 20,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 10),
                      FlSpot(1, 15),
                      FlSpot(2, 14),
                      FlSpot(3, 13),
                      FlSpot(4, 16),
                      FlSpot(5, 18),
                      FlSpot(6, 16),
                    ],
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [Colors.cyan, Colors.blue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    barWidth: 5,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
