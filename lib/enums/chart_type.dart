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
  Chart instance(int singularSize) {
    switch (this) {
      case ChartType.BarChart:
        return BarChartGraph(barWidth: (singularSize * 16.0) / singularSize);
      case ChartType.LineChart:
        return LineChartGraph(lineWidth: singularSize * 3.0);
      case ChartType.PieChart:
        return PieChartGraph(pieRadius: (singularSize * 65.0) / singularSize);
      default:
        return null;
    }
  }
}
