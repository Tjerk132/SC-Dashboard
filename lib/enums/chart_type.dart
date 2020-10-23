import 'dart:convert';
import 'package:flutter/cupertino.dart';
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

  Future<Chart> instance(BuildContext context, int singularSize,
      {int pieCount = 3, int barCount = 7, int lineCount = 3}) async {
    // lineWidth: singularSize * 3.0,
    // barWidth: (singularSize * 16.0) / singularSize,
    // pieRadius: (singularSize * 65.0) / singularSize,
    return getSampleChart(context);
  }

  /// get a sample graph from the local json file (for
  /// testing purposes only)
  Future<Chart> getSampleChart(BuildContext context) async {
    String chartString = await DefaultAssetBundle.of(context)
        .loadString('lib/enums/samples.json');

    String chart = this.toString().split('.').last;
    Map<String, dynamic> s = json.decode(chartString)[chart];

    switch (this) {
      case ChartType.PieChart:
        return PieChartGraph.fromJson(s);
      case ChartType.BarChart:
        return BarChartGraph.fromJson(s);
      case ChartType.LineChart:
        return LineChartGraph.fromJson(s);
      default:
        return null;
    }
  }
}
