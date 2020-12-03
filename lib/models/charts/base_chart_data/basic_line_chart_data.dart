import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_line_chart.dart';

class BasicLineChartData extends LineChartData {
  @protected
  BasicLineChartData._({
    List<ShowingTooltipIndicators> showingTooltipIndicators,
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
          showingTooltipIndicators: showingTooltipIndicators,
          lineBarsData: lineBarsData,
          lineTouchData: lineTouchData,
          gridData: gridData,
          titlesData: titlesData,
          borderData: borderData,
          clipData: FlClipData.all(),
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
        );

  factory BasicLineChartData({
    @required Map<int, List<FlSpot>> spots,
    @required Map<int, Color> colors,
    @required double lineWidth,
    Color showingIndicatorsColor = Colors.black,
    Map<int, String> topTitles,
    Map<int, String> bottomTitles,
    Map<int, String> leftTitles,
    Map<int, String> rightTitles,
    TextStyle titleTextStyle,
    bool showBelowBarData,
    List<Color> belowBarColors,
    double margin,
    LineTouchData lineTouchData,
    FlGridData gridData,
    FlTitlesData titlesData,
    double reservedSize,
    FlBorderData borderData,
    List<ShowingTooltipIndicators> showingTooltipIndicators,
    double minX,
    double maxX,
    double minY,
    double maxY,
  }) {
    spots = spots ?? const [];
    colors = colors ?? const [];
    lineWidth = lineWidth ?? 6.0;
    titleTextStyle = titleTextStyle ?? TextStyle();

    BaseLineChart base = BaseLineChart();

    List<LineChartBarData> lineBarsData = base.lineGroups(
      spots,
      colors,
      lineWidth,
      showBelowBarData: showBelowBarData,
      belowBarColors: belowBarColors,
    );

    //todo now shows only first line
    lineTouchData = lineTouchData ?? base.lineTouchData(showingIndicatorsColor);

    gridData = gridData ?? FlGridData(show: false);
    titlesData = titlesData ??
        base.titleData(
          show: true,
          reservedSize: reservedSize,
          textStyle: titleTextStyle,
          margin: margin,
          topTitles: topTitles,
          bottomTitles: bottomTitles,
          leftTitles: leftTitles,
          rightTitles: rightTitles,
        );

    borderData = borderData ?? FlBorderData(show: false);
    showingTooltipIndicators = showingTooltipIndicators ?? base.tooltipIndicators(spots);

    return BasicLineChartData._(
      lineBarsData: lineBarsData,
      lineTouchData: lineTouchData,
      gridData: gridData,
      titlesData: titlesData,
      borderData: borderData,
      showingTooltipIndicators: showingTooltipIndicators,
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
    );
  }
}
