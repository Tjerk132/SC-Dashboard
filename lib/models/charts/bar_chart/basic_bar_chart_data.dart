import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart.dart';
import 'package:flutter_test_project/utility/utility.dart';

class BasicBarChartData extends BarChartData {
  @protected
  BasicBarChartData._({
    List<BarChartGroupData> barGroups,
    double groupsSpace,
    BarChartAlignment alignment,
    FlTitlesData titlesData,
    BarTouchData barTouchData,
    FlAxisTitleData axisTitleData,
    double maxY,
    double minY,
    FlGridData gridData,
    FlBorderData borderData,
    RangeAnnotations rangeAnnotations,
    Color backgroundColor,
  }) : super(
          barGroups: barGroups,
          groupsSpace: groupsSpace,
          alignment: alignment,
          titlesData: titlesData,
          barTouchData: barTouchData,
          axisTitleData: axisTitleData,
          maxY: maxY,
          minY: minY,
          gridData: gridData,
          borderData: borderData,
          rangeAnnotations: rangeAnnotations,
          backgroundColor: backgroundColor,
        );

  factory BasicBarChartData({
    @required Function(BarTouchResponse) barTouchCallBack,
    @required List<String> barTouchTooltipData,
    @required List<double> barValues,
    @required double barWidth,
    @required int barCount,
    @required int touchedIndex,
    TextStyle textStyle,
    List<BarChartGroupData> barGroups,
    double groupsSpace,
    BarChartAlignment alignment,
    FlTitlesData titlesData,
    BarTouchData barTouchData,
    FlAxisTitleData axisTitleData,
    double maxY,
    double minY,
    FlGridData gridData,
    FlBorderData borderData,
    RangeAnnotations rangeAnnotations,
    Color backgroundColor,
  }) {
    barTouchCallBack = barTouchCallBack ?? (BarTouchResponse barTouchResponse) {};
    barTouchTooltipData = barTouchTooltipData ?? const [];
    barValues = barValues ?? const [];
    barWidth = barWidth ?? 22;
    barCount = barCount ?? 5;
    touchedIndex = touchedIndex ?? -1;
    textStyle = textStyle ?? TextStyle();

    BaseChart base = BaseChart();

    barTouchData = barTouchData ??
        base.baseTouchData(barTouchTooltipData, barTouchCallBack);
    titlesData = titlesData ??
        base.baseTitleData(
          show: true,
          textStyle: textStyle,
          getTitlesBottom: (double value) =>
              barTouchTooltipData.getOrElse(value.toInt(), '').substring(0, 1),
        );
    borderData = borderData ?? FlBorderData(show: false);
    barGroups = barGroups ??
        base.baseBarGroups(barCount, barValues, touchedIndex, barWidth);

    return BasicBarChartData._(
      barGroups: barGroups,
      groupsSpace: groupsSpace,
      alignment: alignment,
      titlesData: titlesData,
      barTouchData: barTouchData,
      axisTitleData: axisTitleData,
      maxY: maxY,
      minY: minY,
      gridData: gridData,
      borderData: borderData,
      rangeAnnotations: rangeAnnotations,
      backgroundColor: backgroundColor,
    );
  }
}
