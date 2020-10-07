import 'package:flutter_test_project/models/charts/bar_chart.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/charts/line_chart.dart';
import 'package:flutter_test_project/models/charts/pie_chart.dart';

enum ChartType {
  LineChart,
  BarChart,
  PieChart,
}

extension ChartTypeExtension on ChartType {

  Chart instance() {
    switch(this) {
      case ChartType.BarChart:
        return BarChartGraph();
      case ChartType.LineChart:
        return LineChartGraph();
      case ChartType.PieChart:
        return PieChartGraph();
      default: return null;
    }
  }
}