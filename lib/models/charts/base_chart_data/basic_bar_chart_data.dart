import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_bar_chart.dart';

class BasicBarChartData extends BarChartData {
  @protected
  BasicBarChartData._({
    List<BarChartGroupData>? barGroups,
    double? groupsSpace,
    BarChartAlignment? alignment,
    FlTitlesData? titlesData,
    BarTouchData? barTouchData,
    double? maxY,
    double? minY,
    FlGridData? gridData,
    FlBorderData? borderData,
    RangeAnnotations? rangeAnnotations,
    Color? backgroundColor,
  }) : super(
          barGroups: barGroups,
          groupsSpace: groupsSpace,
          alignment: alignment,
          titlesData: titlesData,
          barTouchData: barTouchData,
          maxY: maxY,
          minY: minY,
          gridData: gridData,
          borderData: borderData,
          rangeAnnotations: rangeAnnotations,
          backgroundColor: backgroundColor,
        );

  factory BasicBarChartData({
    required List<String> barTouchTooltipData,
    required List<double> barValues,
    required int factor,
    double? barWidth,
    int? rodCount,
    Color? rodColor,
    Color? rodBackgroundColor,
    BorderRadius? rodBorderRadius,
    TextStyle? titlesTextStyle,
    TextStyle? toolTipStyle,
    List<BarChartGroupData>? barGroups,
    double? groupsSpace,
    BarChartAlignment? alignment,
    FlTitlesData? titlesData,
    BarTouchData? barTouchData,
    double? maxY,
    double? minY,
    FlGridData? gridData,
    FlBorderData? borderData,
    RangeAnnotations? rangeAnnotations,
    Color? toolTipBgColor,
    Color? backgroundColor,
  }) {
    barWidth ??= 22;
    rodCount ??= 1;
    rodBorderRadius ??= BorderRadius.circular(20);
    titlesTextStyle ??= TextStyle(color: Colors.white);
    toolTipStyle ??= TextStyle(color: Colors.yellow);
    toolTipBgColor ??= Colors.black;

    BaseBarChart base = BaseBarChart();

    barTouchData ??= base.touchData(
      barTouchTooltipData,
      toolTipStyle: toolTipStyle,
      tooltipBgColor: toolTipBgColor,
    );

    titlesData ??= base.titleData(
      show: true,
      textStyle: titlesTextStyle,
      bottomTitles: barTouchTooltipData.asMap(),
    );

    borderData ??= FlBorderData(show: false);
    barGroups ??= base.barGroups(
      barValues,
      barWidth,
      rodCount,
      factor,
      rodColor: rodColor,
      backgroundColor: rodBackgroundColor,
      rodBorderRadius: rodBorderRadius,
    );

    return BasicBarChartData._(
      barGroups: barGroups,
      groupsSpace: groupsSpace,
      alignment: alignment,
      titlesData: titlesData,
      barTouchData: barTouchData,
      maxY: maxY,
      minY: minY,
      gridData: gridData,
      borderData: borderData,
      rangeAnnotations: rangeAnnotations,
      backgroundColor: backgroundColor,
    );
  }
}
