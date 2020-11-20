import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/utility/utility.dart';

mixin BaseChart {

  FlTitlesData baseTitleData({
    bool show,
    TextStyle textStyle,
    double margin = 0,
    double reservedSize = 0,
    Map<int, String> topTitles,
    Map<int, String> bottomTitles,
    Map<int, String> leftTitles,
    Map<int, String> rightTitles,
  }) {
    return FlTitlesData(
      show: show,
      topTitles: SideTitles(
        showTitles: topTitles != null,
        textStyle: textStyle,
        margin: margin,
        reservedSize: reservedSize,
        getTitles: createTitleFunction(topTitles),
      ),
      bottomTitles: SideTitles(
        showTitles: bottomTitles != null,
        textStyle: textStyle,
        margin: margin,
        getTitles: createTitleFunction(bottomTitles),
      ),
      leftTitles: SideTitles(
        showTitles: leftTitles != null,
        textStyle: textStyle,
        margin: margin,
        getTitles: createTitleFunction(leftTitles),
      ),
      rightTitles: SideTitles(
        showTitles: rightTitles != null,
        textStyle: textStyle,
        margin: margin,
        getTitles:  createTitleFunction(rightTitles),
      ),
    );
  }

  /// Determines how the title of the given [map] will be
  /// retrieved with the current [value] in the map
  String Function(double) createTitleFunction(Map<int, String> map) {
    return (double value) => map.getOrElse(value.toInt(), '');
  }
}
