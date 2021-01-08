import 'package:flutter/cupertino.dart';
import 'package:flutter_test_project/models/charts/bar_chart/bar_chart.dart';
import 'package:flutter_test_project/models/charts/line_chart/line_chart.dart';
import 'package:flutter_test_project/models/charts/pie_chart/pie_chart.dart';
import 'package:flutter_test_project/models/charts/text_chart/text_chart.dart';

enum ChartType {
  LineChart,
  BarChart,
  PieChart,
  Text,
}

extension ChartTypeExtension on ChartType {
  Widget instance(
    Map<String, dynamic> json,
    int singularSize,
    dynamic type,
  ) {
    switch (this) {
      case ChartType.PieChart:
        return PieChartGraph.fromJson(
          json,
          singularSize: singularSize,
          type: type,
        );
      case ChartType.BarChart:
        return BarChartGraph.fromJson(
          json,
          singularSize: singularSize,
        );
      case ChartType.LineChart:
        return LineChartGraph.fromJson(
          json,
          singularSize: singularSize,
        );
      case ChartType.Text:
        return TextChart.fromJson(
          json,
        );
      default:
        return null;
    }
  }
}
