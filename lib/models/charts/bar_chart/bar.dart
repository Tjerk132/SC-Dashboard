import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Bar extends BarChartGroupData {
  Bar(
    int x,
    double y, {
    List<BarChartRodData> barRods,
    Color barBackgroundColor = const Color(0xff72d8bf),
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) : super(
          x: x,
          barRods: barRods,
          showingTooltipIndicators: showTooltips,
        );
}
