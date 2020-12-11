import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_chart.dart';

class BasePieChart with BaseChart {
  List<PieChartSectionData> basePieGroups(
    List<Color> sectionColors,
    double pieRadius,
    List<double> values, {
    bool showPieTitle = true,
    double fontSize = 16,
  }) {
    return List<PieChartSectionData>.generate(
      values.length,
      (i) => PieChartSectionData(
        title: showPieTitle ? '${values[i].toStringAsFixed(1)}%' : '',
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: showPieTitle ? Colors.white : sectionColors[i],
        ),
        color: sectionColors[i],
        value: values[i],
        radius: pieRadius,
      ),
    );
  }
}
