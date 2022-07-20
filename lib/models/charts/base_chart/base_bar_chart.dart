import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_chart.dart';
import 'package:flutter_test_project/utility/utility.dart';

class BaseBarChart with BaseChart {
  BarTouchData touchData(
    List<String> barTouchTooltipData, {
    required TextStyle toolTipStyle,
    Color? tooltipBgColor,
  }) {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: tooltipBgColor,
        fitInsideVertically: true,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          // int x = group.x.toInt();
          // String tooltip = barTouchTooltipData[x];
          return BarTooltipItem(
            //'$tooltip\n${rod.y}'
            rod.toY.toString(), //rod.y.toString()
            toolTipStyle,
          );
        },
      ),
    );
  }

  List<BarChartGroupData> barGroups(
    List<double> barValues,
    double barWidth,
    int rodCount,
    int factor, {
    Color? rodColor = Colors.yellowAccent,
    Color? backgroundColor,
    BorderRadius? rodBorderRadius,
    bool showBackGround = true,
  }) {
    double width = factor + (barWidth / rodCount);
    List<BarChartGroupData> bars = <BarChartGroupData>[];

    barValues.asMap().forEach((i, value) {
      double y = barValues.getOrElse(i, 0);
      bars.add(
        new BarChartGroupData(
          x: i,
          barRods: List<BarChartRodData>.generate(
            rodCount,
            (i) => createRod(
              y,
              barValues.highest.roundToFactor(10).toDouble(),
              width: width,
              color: rodColor,
              backgroundColor: backgroundColor,
              borderRadius: rodBorderRadius,
              showBackGround: showBackGround,
            ),
          ),
        ),
      );
    });

    return bars;
  }

  BarChartRodData createRod(
    double y,
    double backDrawRodDataY, {
    double? width,
    Color? color,
    Color? backgroundColor = const Color(0xff72d8bf),
    BorderRadius? borderRadius = BorderRadius.zero,
    bool showBackGround = true,
  }) {
    return BarChartRodData(
      toY: y,
      color: color,
      width: width,
      borderRadius: borderRadius,
      backDrawRodData: BackgroundBarChartRodData(
        show: showBackGround,
        toY: backDrawRodDataY,
        color: backgroundColor,
      ),
    );
  }
}
