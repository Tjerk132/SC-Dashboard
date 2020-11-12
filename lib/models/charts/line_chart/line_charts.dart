import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Tjerk_2/Desktop/Flutter-TestApp/lib/models/charts/base_chart_data/basic_line_chart_data.dart';

class LineCharts {
  LineCharts(this.lineWidth, this.lineCount);

  final double lineWidth;
  final int lineCount;

  BasicLineChartData mainDataGraph(
    double minX,
    double maxX,
    double maxY,
    double minY,
    Map<int, List<FlSpot>> spots,
    Map<int, Color> colors,
    FlGridData gridData,
    TextStyle textStyle, {
    Map<int, String> topTitles,
    Map<int, String> bottomTitles,
    Map<int, String> leftTitles,
    Map<int, String> rightTitles,
    Color borderColor = const Color(0xff4e4965),
  }) {
    return BasicLineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: gridData,
      reservedSize: 22,
      // borderData: FlBorderData(
      //     show: true,
      //     border: Border.all(color: const Color(0xff37434d), width: 1)),
      margin: 8,
      topTitles: topTitles,
      bottomTitles: bottomTitles,
      leftTitles: leftTitles,
      rightTitles: rightTitles,
      minX: minX,
      maxX: maxX,
      maxY: maxY,
      minY: minY,
      lineCount: lineCount,
      spots: spots,
      colors: colors,
      lineWidth: lineWidth,

      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: borderColor, width: 2),
          left: BorderSide(color: borderColor, width: 2),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      textStyle: textStyle,
    );
  }

  BasicLineChartData otherDataGraph(
    double minX,
    double maxX,
    double maxY,
    double minY,
    Map<int, List<FlSpot>> spots,
    Map<int, Color> colors,
    FlGridData gridData, {
    Map<int, String> topTitles,
    Map<int, String> bottomTitles,
    Map<int, String> leftTitles,
    Map<int, String> rightTitles,
    Color borderColor = const Color(0xff4e4965),
  }) {
    return BasicLineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: gridData,
      showBelowBarData: true,

      reservedSize: 22,
      // borderData: FlBorderData(
      //     show: true,
      //     border: Border.all(color: const Color(0xff37434d), width: 1)),
      margin: 16,
      // reservedSize: 22,
      // //16 for sale 8 for stocks
      // margin: 16,

      topTitles: topTitles,
      bottomTitles: bottomTitles,
      leftTitles: leftTitles,
      rightTitles: rightTitles,
      minX: minX,
      maxX: maxX,
      maxY: maxY,
      minY: minY,
      lineCount: lineCount,
      spots: spots,
      colors: colors,
      lineWidth: lineWidth,
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: borderColor, width: 4),
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
