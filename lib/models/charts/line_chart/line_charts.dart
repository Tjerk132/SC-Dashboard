import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/line_chart/basic_line_chart_data.dart';

class LineCharts {
  LineCharts(this.lineWidth, this.lineCount);

  final double lineWidth;
  final int lineCount;

  BasicLineChartData mainDataGraph(List<String> leftTitles,
      Map<int, String> bottomTitles,
      Map<int, List<FlSpot>> spots, Map<int, Color> colors) {
    return BasicLineChartData(
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
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      textStyle: TextStyle(
        color: Colors.grey[200],
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  BasicLineChartData otherDataGraph(List<String> leftTitles,
      Map<int, String> bottomTitles,
      Map<int, List<FlSpot>> spots, Map<int, Color> colors) {
    return BasicLineChartData(
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
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      textStyle: TextStyle(
        color: Colors.grey[200],
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }
}
