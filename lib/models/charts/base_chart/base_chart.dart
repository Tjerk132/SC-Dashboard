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
    bool showTop = topTitles != null;
    bool showBottom = bottomTitles != null;
    bool showLeft = leftTitles != null;
    bool showRight = rightTitles != null;

    final String Function(double) getTopTitles = createTitleFunction(topTitles);
    final String Function(double) getBottomTitles = createTitleFunction(bottomTitles);
    final String Function(double) getLeftTitles = createTitleFunction(leftTitles);
    final String Function(double) getRightTitles = createTitleFunction(rightTitles);

    return FlTitlesData(
      show: show,
      topTitles: SideTitles(
        showTitles: showTop,
        textStyle: textStyle,
        margin: margin,
        reservedSize: reservedSize,
        getTitles: getTopTitles,
      ),
      bottomTitles: SideTitles(
        showTitles: showBottom,
        textStyle: textStyle,
        margin: margin,
        getTitles: getBottomTitles,
      ),
      leftTitles: SideTitles(
        showTitles: showLeft,
        textStyle: textStyle,
        margin: margin,
        getTitles: getLeftTitles,
      ),
      rightTitles: SideTitles(
        showTitles: showRight,
        textStyle: textStyle,
        margin: margin,
        getTitles: getRightTitles,
      ),
    );
  }

  /// Determines how the title of the given [map] will be
  /// retrieved with the current [value] in the map
  String Function(double) createTitleFunction(Map<int, String> map) {
    return (double value) => map.getOrElse(value.toInt(), '');
  }
}
