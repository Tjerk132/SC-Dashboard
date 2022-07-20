import 'package:flutter_test_project/models/charts/bar_chart/bar_chart.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/charts/line_chart/line_chart.dart';
import 'package:flutter_test_project/models/charts/pie_chart/pie_chart.dart';
import 'package:flutter_test_project/models/charts/text_chart/text_chart.dart';

enum ChartType {
  LineChart,
  BarChart,
  PieChart,
  TextChart,
}

extension ChartTypeExtension on ChartType {
  Chart instance(Map<String, dynamic> json) {
    switch (this) {
      case ChartType.PieChart:
        return PieChartGraph.fromJson(json);
      case ChartType.BarChart:
        return BarChartGraph.fromJson(json);
      case ChartType.LineChart:
        return LineChartGraph.fromJson(json);
      case ChartType.TextChart:
        return TextChart.fromJson(json);
    }
  }
}
