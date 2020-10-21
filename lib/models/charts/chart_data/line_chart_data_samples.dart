import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/line_chart/lines.dart';

class LineChartDataSamples {
  LineChartDataSamples(this.lineWidth, this.lineCount);

  final double lineWidth;
  final int lineCount;

  Lines sampleData1(List<String> leftTitles, Map<int, String> bottomTitles,
      Map<int, List<FlSpot>> spots, Map<int, Color> colors) {
    return Lines(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      bottomTitles: bottomTitles,
      leftTitles: leftTitles,
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineCount: lineCount,
      spots: spots,
      colors: colors,
      lineWidth: lineWidth,
    );
  }

  Lines sampleData2(List<String> leftTitles, Map<int, String> bottomTitles,
      Map<int, List<FlSpot>> spots, Map<int, Color> colors) {
    return Lines(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      bottomTitles: bottomTitles,
      leftTitles: leftTitles,
      minX: 0,
      maxX: 14,
      minY: 0,
      maxY: 6,
      lineCount: lineCount,
      spots: spots,
      colors: colors,
      lineWidth: lineWidth,
    );
  }
}
