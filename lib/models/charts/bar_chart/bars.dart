import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart.dart';
import 'package:flutter_test_project/utility/utility.dart';

class Bars extends BarChartData {

  @protected
  Bars._({
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

  factory Bars({
    @required Function(BarTouchResponse) barTouchCallBack,
    @required List<String> barTouchTooltipData,
    @required List<double> barValues,
    @required double barWidth,
    @required int barCount,
    @required int touchedIndex,
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
    //todo give usable fallback value for callback
    barTouchCallBack = barTouchCallBack ?? () {};
    barTouchTooltipData = barTouchTooltipData ?? const [];
    barValues = barValues ?? const [];
    barWidth = barWidth ?? 22;
    barCount = barCount ?? 5;
    touchedIndex = touchedIndex ?? -1;

    BaseChart base = BaseChart();

    barTouchData = barTouchData ??
        base.baseTouchData(barTouchTooltipData, barTouchCallBack);
    titlesData = titlesData ??
        base.baseTitleData(
          showTitles: true,
          getTitlesBottom: (double value) =>
              barTouchTooltipData.getOrElse(value.toInt(), '').substring(0, 1),
          showBottomTitles: true,
          showLeftTitles: false,
        );
    borderData = borderData ?? FlBorderData(show: false);
    barGroups = barGroups ??
        base.baseBarGroups(barCount, barValues, touchedIndex, barWidth);

    return Bars._(
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
