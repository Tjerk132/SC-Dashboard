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
  Future<Chart> instance(Map<String, dynamic> jsonChart, int singularSize, dynamic type) async {
    return getSampleChart(jsonChart, singularSize, type);
  }

  Future<Chart> getSampleChart(Map<String, dynamic> jsonChart, int singularSize, dynamic type) async {

    //random between styles (for testing purposes only)
    // Random r = new Random();
    switch (this) {
      case ChartType.PieChart:
        // type = type as PieChartType;
        // PieChartType type = r.nextObject(PieChartType.values);
        return PieChartGraph.fromJson(
          jsonChart,
          singularSize: singularSize,
          type: type,
        );
      case ChartType.BarChart:
        return BarChartGraph.fromJson(
          jsonChart,
          singularSize: singularSize,
        );
      case ChartType.LineChart:
        // LineChartType type = r.nextObject(LineChartType.values);
        return LineChartGraph.fromJson(
          jsonChart,
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
