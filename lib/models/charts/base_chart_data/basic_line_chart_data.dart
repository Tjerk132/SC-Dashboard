import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_line_chart.dart';

class BasicLineChartData extends LineChartData {
  @protected
  BasicLineChartData._({
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

  factory BasicLineChartData({
    @required int lineCount,
    @required Map<int, List<FlSpot>> spots,
    @required Map<int, Color> colors,
    @required double lineWidth,
    Map<int, String> topTitles,
    Map<int, String> bottomTitles,
    Map<int, String> leftTitles,
    Map<int, String> rightTitles,
    TextStyle textStyle,
    bool showBelowBarData,
    List<Color> belowBarColors,
    double margin,
    LineTouchData lineTouchData,
    FlGridData gridData,
    FlTitlesData titlesData,
    double reservedSize,
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
    textStyle = textStyle ?? TextStyle();

    BaseLineChart base = BaseLineChart();

    List<LineChartBarData> lineBarsData = base.baseLineGroups(
      lineCount,
      spots,
      colors,
      lineWidth,
      showBelowBarData: showBelowBarData,
      belowBarColors: belowBarColors,
    );

    gridData = gridData ?? FlGridData(show: false);
    titlesData = titlesData ??
        base.baseTitleData(
          show: true,
          reservedSize: reservedSize,
          textStyle: textStyle,
          margin: margin,
          topTitles: topTitles,
          bottomTitles: bottomTitles,
          leftTitles: leftTitles,
          rightTitles: rightTitles,
        );
    borderData = borderData ?? FlBorderData(show: false);

    return BasicLineChartData._(
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
