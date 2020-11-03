import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

mixin BaseChart {

  FlTitlesData baseTitleData({
    bool show,
    TextStyle textStyle,
    double margin = 0,
    double reservedSize = 0,
    String Function(double) getTitlesTop,
    String Function(double) getTitlesBottom,
    String Function(double) getTitlesLeft,
    String Function(double) getTitlesRight,
  }) {
    bool showTop = getTitlesTop != null;
    bool showBottom = getTitlesBottom != null;
    bool showLeft = getTitlesLeft != null;
    bool showRight = getTitlesRight != null;
    return FlTitlesData(
      show: show,
      topTitles: SideTitles(
        showTitles: showTop,
        textStyle: textStyle,
        margin: margin,
        reservedSize: reservedSize,
        getTitles: getTitlesTop,
      ),
      bottomTitles: SideTitles(
        showTitles: showBottom,
        textStyle: textStyle,
        margin: margin,
        getTitles: getTitlesBottom,
      ),
      leftTitles: SideTitles(
        showTitles: showLeft,
        textStyle: textStyle,
        margin: margin,
        getTitles: getTitlesLeft,
      ),
      rightTitles: SideTitles(
        showTitles: showRight,
        textStyle: textStyle,
        margin: margin,
        getTitles: getTitlesRight,
      ),
    );
  }
}
