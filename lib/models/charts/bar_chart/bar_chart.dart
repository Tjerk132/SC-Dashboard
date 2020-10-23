import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/charts/chart_data.dart';

import 'basic_bar_chart_data.dart';

class BarChartGraph extends Chart {
  final double barWidth;
  final int barCount;
  final List<double> barValues;
  final List<String> barTouchTooltipData;

  BarChartGraph({
    this.barWidth,
    this.barCount = 7,
    this.barValues = const [],
    this.barTouchTooltipData = const [],
  });

  factory BarChartGraph.fromJson(Map<String, dynamic> json) {
    return new BarChartGraph(
      barWidth: json["barWidth"] as double,
      barCount: json["barCount"] as int,
      barValues: (json["barValues"] as List<dynamic>).cast<double>(),
      barTouchTooltipData: (json["barTouchTooltipData"] as List<dynamic>).cast<String>(),
    );
  }

  @override
  State<BarChartGraph> createState() => BarChartGraphState();
}

class BarChartGraphState extends State<BarChartGraph> {

  int touchedIndex;

  void barTouchCallBack(BarTouchResponse barTouchResponse) {
    setState(() {
      if (barTouchResponse.spot != null &&
          barTouchResponse.touchInput is! FlPanEnd &&
          barTouchResponse.touchInput is! FlLongPressEnd) {
        touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
      } else {
        touchedIndex = -1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: const Color(0xff81e5cd),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                alignment: Alignment.topRight,
                icon: Icon(
                  Icons.play_arrow,
                  color: const Color(0xff0f4a3c),
                ),
                onPressed: () => print('No onPress implemented'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ChartData(
              data: BarChart(
                BasicBarChartData(
                  barTouchCallBack: barTouchCallBack,
                  barTouchTooltipData: widget.barTouchTooltipData,
                  barValues: widget.barValues,
                  barWidth: widget.barWidth,
                  barCount: widget.barCount,
                  touchedIndex: touchedIndex,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              title: 'Bar graph title',
              subTitle: 'Bar graph subtext',
            ),
          ),
        ],
      ),
    );
  }
}
