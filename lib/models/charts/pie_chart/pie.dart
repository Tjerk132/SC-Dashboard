import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/painting.dart';

class Pie extends PieChartSectionData {
  Pie({
    Color color,
    Color titleColor,
    double value,
    String title,
    bool isTouched,
    double pieRadius,
    var badgeWidget,
    double titlePositionPercentageOffset = 0.55,
  }) : super(
          color: color.withOpacity(isTouched ? 1 : 0.6),
          value: value,
          title: title,
          radius: isTouched ? pieRadius * 1.2 : pieRadius,
          titleStyle: TextStyle(
            fontSize: isTouched ? 25 : 16,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
          titlePositionPercentageOffset: titlePositionPercentageOffset,
        );
}
