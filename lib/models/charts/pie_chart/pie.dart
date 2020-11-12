import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/painting.dart';

class Pie extends PieChartSectionData {
  Pie({
    Color color,
    Color titleColor,
    double fontSize = 16,
    double value,
    String title,
    bool isTouched,
    double pieRadius,
    double titlePositionPercentageOffset = 0.50,
  }) : super(
          color: color.withOpacity(isTouched ? 1 : 0.7),
          value: value,
          title: title,
          radius: isTouched ? pieRadius * 1.15 : pieRadius,
          titleStyle: TextStyle(
            fontSize: isTouched ? fontSize + 4 : fontSize,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
          titlePositionPercentageOffset: titlePositionPercentageOffset,
        );
}
