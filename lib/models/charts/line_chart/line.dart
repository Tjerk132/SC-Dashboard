import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Line extends LineChartBarData {
  Line({
    List<FlSpot> spots,
    bool isCurved,
    double curveSmoothness,
    List<Color> colors,
    double barWidth,
    bool isStrokeCapRound,
    FlDotData dotData,
    BarAreaData belowBarData,
  }) : super(
          spots: spots,
          isCurved: isCurved,
          curveSmoothness: curveSmoothness,
          colors: colors,
          barWidth: barWidth,
          isStrokeCapRound: isStrokeCapRound,
          dotData: dotData,
          belowBarData: belowBarData,
        );
}
