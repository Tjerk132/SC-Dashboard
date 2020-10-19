import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Bar extends BarChartGroupData {
  Bar(
    int x,
    double y, {
    Color barBackgroundColor = const Color(0xff72d8bf),
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) : super(
          x: x,
          barRods: [
            BarChartRodData(
              y: isTouched ? y + 1 : y,
              color: isTouched ? Colors.yellow : barColor,
              width: width,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                y: 20,
                color: barBackgroundColor,
              ),
            ),
          ],
          showingTooltipIndicators: showTooltips,
        );
}
