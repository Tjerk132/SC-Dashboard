import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/line_chart/line.dart';
import 'package:flutter_test_project/utility/utility.dart';

class Lines extends LineChartData {
  final int lineCount;
  final Map<int, List<FlSpot>> spots;
  final Map<int, Color> colors;
  final double lineWidth;

  @protected
  Lines._({
    this.lineCount,
    this.spots,
    this.colors,
    this.lineWidth,
    List<LineChartBarData> lineBarsData,
    LineTouchData lineTouchData,
    FlGridData gridData,
    FlTitlesData titlesData,
    FlBorderData borderData,
    double minX,
    double maxX,
    double minY,
    double maxY,
  }) : super(
          lineBarsData: lineBarsData,
          lineTouchData: lineTouchData,
          gridData: gridData,
          titlesData: titlesData,
          borderData: borderData,
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
        );

  factory Lines({
    @required int lineCount,
    @required Map<int, List<FlSpot>> spots,
    @required Map<int, Color> colors,
    @required double lineWidth,
    @required List<String> leftTitles,
    @required Map<int, String> bottomTitles,
    LineTouchData lineTouchData,
    FlGridData gridData,
    FlTitlesData titlesData,
    FlBorderData borderData,
    double minX,
    double maxX,
    double minY,
    double maxY,
  }) {
    lineCount = lineCount ?? 3;
    spots = spots ?? const [];
    colors = colors ?? const [];
    lineWidth = lineWidth ?? 6.0;

    List<LineChartBarData> lineBarsData = List<Line>.generate(
      lineCount,
      (index) => Line(
        spots: spots[index],
        isCurved: true,
        colors: [
          colors[index],
        ],
        barWidth: lineWidth,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
          //for purple only
          colors: [
            const Color(0x00aa4cfc),
          ],
        ),
      ),
    );
    gridData = gridData ?? FlGridData(show: false);
    titlesData = titlesData ??
        FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            textStyle: const TextStyle(
              color: Color(0xff72719b),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            margin: 10,
            getTitles: (value) {
              int iValue = value.toInt();
              return bottomTitles.getOrElse(iValue, '');
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            textStyle: const TextStyle(
              color: Color(0xff75729e),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            getTitles: (value) {
              int iValue = value.toInt();
              return leftTitles.getOrElse(iValue, '');
            },
            margin: 8,
            reservedSize: 30,
          ),
        );
    borderData = borderData ??
        FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          ),
        );

    return Lines._(
      lineCount: lineCount,
      spots: spots,
      colors: colors,
      lineWidth: lineWidth,
      lineBarsData: lineBarsData,
      lineTouchData: lineTouchData,
      gridData: gridData,
      titlesData: titlesData,
      borderData: borderData,
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
    );
  }
}
