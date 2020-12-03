import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_pie_chart.dart';

class BasicPieChartData extends PieChartData {
  @protected
  BasicPieChartData._({
    List<PieChartSectionData> sections,
    double centerSpaceRadius,
    Color centerSpaceColor,
    double sectionsSpace,
    double startDegreeOffset,
    PieTouchData pieTouchData,
    FlBorderData borderData,
  }) : super(
          sections: sections,
          centerSpaceRadius: centerSpaceRadius,
          centerSpaceColor: centerSpaceColor,
          sectionsSpace: sectionsSpace,
          startDegreeOffset: startDegreeOffset,
          pieTouchData: pieTouchData,
          borderData: borderData,
        );

  factory BasicPieChartData({
    @required List<Color> sectionColors,
    @required List<double> values,
    @required double pieRadius,
    double fontSize,
    bool showPieTitle,
    double centerSpaceRadius,
    Color centerSpaceColor,
    double sectionsSpace,
    double startDegreeOffset,
    PieTouchData pieTouchData,
    FlBorderData borderData,
  }) {
    sectionColors = sectionColors ?? const [];
    values = values ?? List.filled(sectionColors.length, 100 / sectionColors.length);
    pieRadius = pieRadius ?? 60;
    BasePieChart base = BasePieChart();

    List<PieChartSectionData> sections = base.basePieGroups(
      sectionColors,
      pieRadius,
      values,
      showPieTitle: showPieTitle,
      fontSize: fontSize,
    );

    return BasicPieChartData._(
      sections: sections,
      centerSpaceRadius: centerSpaceRadius,
      centerSpaceColor: centerSpaceColor,
      sectionsSpace: sectionsSpace,
      startDegreeOffset: startDegreeOffset,
      pieTouchData: pieTouchData,
      borderData: borderData,
    );
  }
}
