import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_chart.dart';
import 'package:flutter_test_project/models/charts/line_chart/line.dart';

class BaseLineChart with BaseChart {
  List<LineChartBarData> baseLineGroups(
    int count,
    Map<int, List<FlSpot>> spots,
    Map<int, Color> colors,
    double lineWidth,
  ) {
    return List<Line>.generate(
      count,
      (i) => Line(
        spots: spots[i],
        isCurved: true,
        colors: [colors[i]],
        barWidth: lineWidth,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false,
            //todo should be for purple only
            colors: [
              // [const Color(0x00aa4cfc)],
              //todo only for stocks graph
              ColorTween(begin: Color(0xff23b6e6), end: Color(0xff02d39a))
                  .lerp(0.2).withOpacity(0.1),
              ColorTween(begin: Color(0xff23b6e6), end: Color(0xff02d39a))
                  .lerp(0.2).withOpacity(0.1),
            ]),
      ),
    );
  }
}
