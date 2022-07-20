import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

mixin BaseChart {
  FlTitlesData titleData({
    required bool show,
    TextStyle? textStyle,
    double? margin = 0,
    double? reservedSize = 0,
    Map<int, String>? topTitles,
    Map<int, String>? bottomTitles,
    Map<int, String>? leftTitles,
    Map<int, String>? rightTitles,
  }) {
    return FlTitlesData(
      show: show,
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: topTitles != null,
          reservedSize: reservedSize,
          getTitlesWidget: createTitleFunction(
            topTitles,
            textStyle: textStyle,
            margin: margin,
          ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: bottomTitles != null,
          reservedSize: reservedSize,
          getTitlesWidget: createTitleFunction(
            bottomTitles,
            textStyle: textStyle,
            margin: margin,
          ),
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: leftTitles != null,
          reservedSize: reservedSize,
          getTitlesWidget: createTitleFunction(
            leftTitles,
            textStyle: textStyle,
            margin: margin,
          ),
        ),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: rightTitles != null,
          reservedSize: reservedSize,
          getTitlesWidget: createTitleFunction(
            rightTitles,
            textStyle: textStyle,
            margin: margin,
          ),
        ),
      ),
    );
  }

  /// Determines how the title of the given [map] will be
  /// retrieved with the current [value] in the map
  Widget Function(double, TitleMeta) createTitleFunction(
    Map<int, String>? map, {
    TextStyle? textStyle = const TextStyle(),
    double? margin,
  }) {
    return (double value, TitleMeta meta) => Container(
          margin: EdgeInsets.all(margin ?? 0),
          child: Text(
            map?[value.toInt()] ?? '',
            style: textStyle,
          ),
        );
  }
}
