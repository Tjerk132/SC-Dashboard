import 'package:flutter_test_project/models/charts/bar_chart/bar_chart.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/charts/line_chart/line_chart.dart';
import 'package:flutter_test_project/models/charts/pie_chart/pie_chart.dart';

enum ChartType {
  LineChart,
  BarChart,
  PieChart,
}

extension ChartTypeExtension on ChartType {

  Future<Chart> instance(Map<String, dynamic> json, int singularSize, dynamic type) async {
    switch (this) {
      case ChartType.PieChart:
      // PieChartType type = r.nextObject(PieChartType.values);
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
      // LineChartType type = r.nextObject(LineChartType.values);
        return LineChartGraph.fromJson(
          json,
          singularSize: singularSize,
          type: type,
        );
      //barWidth: (singularSize * 16.0) / singularSize);
      //singularSize * 3.0
      default:
        return null;
    }
  }
}
