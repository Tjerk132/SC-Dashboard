import 'package:flutter/cupertino.dart';
import 'package:flutter_test_project/models/charts/bar_chart/bar_chart.dart';
import 'package:flutter_test_project/models/charts/line_chart/line_chart.dart';
import 'package:flutter_test_project/models/charts/pie_chart/pie_chart.dart';
import 'package:flutter_test_project/models/charts/text_chart/text_chart.dart';

enum TileGroupType {
  LineChart,
  BarChart,
  PieChart,
  Text,
}

extension ChartTypeExtension on TileGroupType {
  Future<Widget> instance(
    Map<String, dynamic> json,
    int singularSize,
    dynamic type,
  ) async {
    switch (this) {
      case TileGroupType.PieChart:
        return PieChartGraph.fromJson(
          json,
          singularSize: singularSize,
          type: type,
        );
      case TileGroupType.BarChart:
        return BarChartGraph.fromJson(
          json,
          singularSize: singularSize,
        );
      case TileGroupType.LineChart:
        return LineChartGraph.fromJson(
          json,
          singularSize: singularSize,
        );
      case TileGroupType.Text:
        return TextChart.fromJson(
          json,
        );
      default:
        return null;
    }
  }
}
