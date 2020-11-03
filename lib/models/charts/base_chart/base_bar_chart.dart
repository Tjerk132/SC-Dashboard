import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_chart.dart';
import 'package:flutter_test_project/utility/utility.dart';
import '../bar_chart/bar.dart';

class BaseBarChart with BaseChart {

  BarTouchData baseTouchData(
    List<String> barTouchTooltipData,
    Function(BarTouchResponse) barTouchCallBack, {
    TextStyle toolTipStyle,
    Color tooltipBgColor,
  }) {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: tooltipBgColor,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            int x = group.x.toInt();
            String tooltip = barTouchTooltipData[x];
            return BarTooltipItem(
              '$tooltip\n${rod.y - 1}',
              toolTipStyle,
            );
          }),
      touchCallback: (barTouchResponse) => barTouchCallBack(barTouchResponse),
    );
  }

  List<BarChartGroupData> baseBarGroups(
      int count,
      List<double> barValues,
      int touchedIndex,
      double barWidth,
      int rodCount,
      int singularSize, {
        Color backgroundColor,
        BorderRadius rodBorderRadius = BorderRadius.zero,
        bool showBackGround = true,
      }) {
    double width = singularSize + (barWidth / rodCount);
    List<Bar> bars = new List<Bar>();
    for (int i = 0; i < count; ++i) {
      bool isTouched = i == touchedIndex;
      int x = i;
      double y = barValues.getOrElse(i, null);
      bars.add(
        new Bar(
          x,
          y,
          width: width,
          barRods: List<BarChartRodData>.generate(
            rodCount,
                (i) => createRod(
              isTouched ? y + 1 : y,
              barValues.highest.roundToFactor(10) + 1.0,
              width: width,
              color: isTouched ? Colors.yellowAccent : Colors.white,
              backgroundColor: backgroundColor,
              borderRadius: rodBorderRadius,
              showBackGround: showBackGround,
            ),
          ),
        ),
      );
    }
    return bars;
  }

  BarChartRodData createRod(
    double y,
    double backDrawRodDataY, {
    double width,
    Color color,
    Color backgroundColor = const Color(0xff72d8bf),
    BorderRadius borderRadius,
    bool showBackGround,
  }) {
    return BarChartRodData(
      y: y,
      color: color,
      width: width,
      borderRadius: borderRadius,
      backDrawRodData: showBackGround
          ? BackgroundBarChartRodData(
              show: true,
              y: backDrawRodDataY,
              color: backgroundColor,
            )
          : BackgroundBarChartRodData(),
    );
  }
}
