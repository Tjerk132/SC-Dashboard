import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_bar_chart.dart';

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
    @required String Function(String) getBottomTitle,
    @required List<String> barTouchTooltipData,
    @required List<double> barValues,
    @required double barWidth,
    @required int barCount,
    @required int touchedIndex,
    @required int singularSize,
    int rodCount,
    Color rodColor,
    Color rodTouchedColor,
    Color rodBackgroundColor,
    BorderRadius rodBorderRadius,
    TextStyle titlesTextStyle,
    TextStyle toolTipStyle,
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
    Color toolTipBgColor,
    Color backgroundColor,
  }) {
    barTouchCallBack = barTouchCallBack ?? (BarTouchResponse barTouchResponse) {};
    getBottomTitle = getBottomTitle ?? (String title) => title;
    barTouchTooltipData = barTouchTooltipData ?? const [];
    barValues = barValues ?? const [];
    barWidth = barWidth ?? 22;
    barCount = barCount ?? 5;
    touchedIndex = touchedIndex ?? -1;

    rodCount = rodCount ?? 1;
    rodBorderRadius = rodBorderRadius ?? BorderRadius.circular(20);
    titlesTextStyle = titlesTextStyle ?? TextStyle(color: Colors.white);
    toolTipStyle = toolTipStyle ?? TextStyle(color: Colors.yellow);
    toolTipBgColor = toolTipBgColor ?? Colors.black;

    BaseBarChart base = BaseBarChart();

    barTouchData = barTouchData ??
        base.baseTouchData(
          barTouchTooltipData,
          barTouchCallBack,
          toolTipStyle: toolTipStyle,
          tooltipBgColor: toolTipBgColor,
        );

    titlesData = titlesData ??
        base.baseTitleData(
          show: true,
          textStyle: titlesTextStyle,
          bottomTitles: barTouchTooltipData.asMap(),
        );

    borderData = borderData ?? FlBorderData(show: false);
    barGroups = barGroups ??
        base.baseBarGroups(
          barCount,
          barValues,
          touchedIndex,
          barWidth,
          rodCount,
          singularSize,
          rodColor: rodColor,
          rodTouchedColor: rodTouchedColor,
          backgroundColor: rodBackgroundColor,
          rodBorderRadius: rodBorderRadius,
        );

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
