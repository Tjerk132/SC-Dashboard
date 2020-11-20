import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/painting.dart';

class Pie extends PieChartSectionData {
  Pie({
    Color color,
    Color titleColor,
    double fontSize = 16,
    double value,
    String title,
    double pieRadius,
    double titlePositionPercentageOffset = 0.50,
  }) : super(
          color: color.withOpacity(0.7),
          value: value,
          title: title,
          radius: pieRadius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
          titlePositionPercentageOffset: titlePositionPercentageOffset,
        );
}
