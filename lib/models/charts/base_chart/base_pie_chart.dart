import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_chart.dart';
import 'package:flutter_test_project/models/charts/base_chart_data/basic_pie_chart_data.dart';

class BasePieChart with BaseChart {
  List<PieChartSectionData> basePieGroups(
    List<Color> sectionColors,
    double pieRadius,
    List<double> values, {
    bool? showPieTitle,
    double? fontSize = 16,
  }) {
    return List<PieChartSectionData>.generate(
      values.length,
      (i) => PieChartSectionData(
        title: showPieTitle ?? true ? '${values[i].toStringAsFixed(1)}%' : '',
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: showPieTitle ?? true ? Colors.white : sectionColors[i],
        ),
        color: sectionColors[i],
        value: values[i],
        radius: pieRadius,
      ),
    );
  }

  // @override
  // Widget Function(double p1, TitleMeta p2) createTitleFunction(Map<int, String>? map, {TextStyle? textStyle = const TextStyle(), double? margin}) {
  //   this.createTitleFunction(map);
  // }
  //
  // @override
  // FlTitlesData titleData({required bool show, TextStyle? textStyle, double? margin = 0, double? reservedSize = 0, Map<int, String>? topTitles, Map<int, String>? bottomTitles, Map<int, String>? leftTitles, Map<int, String>? rightTitles}) {
  //   // TODO: implement titleData
  //   throw UnimplementedError();
  // }
}
