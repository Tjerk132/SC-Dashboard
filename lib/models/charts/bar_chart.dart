import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';

import 'bar_chart/bars.dart';

class BarChartGraph extends Chart {
  BarChartGraph({this.barWidth});

  final double barWidth;

  @override
  State<BarChartGraph> createState() => BarChartGraphState();
}

class BarChartGraphState extends State<BarChartGraph> {
  // testing data
  final List<String> daysOfTheWeek = const [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  final List<double> barValues = const [5.0, 6.5, 5.0, 7.5, 9.0, 11.5, 6.5];
  final int barCount = 7;

  int touchedIndex;

  void barTouchCallBack(BarTouchResponse barTouchResponse) {
    setState(() {
      if (barTouchResponse.spot != null &&
          barTouchResponse.touchInput is! FlPanEnd &&
          barTouchResponse.touchInput is! FlLongPressEnd) {
        touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
      }
      else {
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
            child: Bars(
              title: 'Bar graph title',
              subTitle: 'Bar graph subtext',
              barWidth: widget.barWidth,
              barCount: barCount,
              touchedIndex: touchedIndex,
              barValues: barValues,
              barTouchTooltipData: daysOfTheWeek,
              barTouchCallBack: barTouchCallBack,
            ),
          ),
        ],
      ),
    );
  }
}
