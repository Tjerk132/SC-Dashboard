import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_chart.dart';
import 'package:flutter_test_project/models/charts/pie_chart/pie.dart';

class BasePieChart with BaseChart {
  List<Pie> basePieGroups(
    int count,
    List<Color> sectionColors,
    double pieRadius,
    List<double> values, {
    bool showPieTitle = true,
    double fontSize = 16,
  }) {
    return List<Pie>.generate(
      count,
      (i) => Pie(
        title: showPieTitle ? '${values[i].toStringAsFixed(1)}%' : '',
        titleColor: showPieTitle ? Colors.white : sectionColors[i],
        fontSize: fontSize,
        color: sectionColors[i],
        value: values[i],
        pieRadius: pieRadius,
      ),
    );
  }
}
