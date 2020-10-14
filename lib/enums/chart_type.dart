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

  Chart instance(int index) {
    switch(this) {
      case ChartType.BarChart:
        return BarChartGraph(index);
      case ChartType.LineChart:
        return LineChartGraph(index);
      case ChartType.PieChart:
        return PieChartGraph(index);
      default: return null;
    }
  }
}