import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/charts/chart_title.dart';

import 'chart_data/bar_chart_data_samples.dart';

class BarChartGraph extends Chart {
  BarChartGraph({this.barWidth});

  final double barWidth;

  @override
  State<BarChartGraph> createState() => BarChartGraphState(this.barWidth);
}

class BarChartGraphState extends State<BarChartGraph> {
  BarChartGraphState(double barWidth) {
    sample = BarChartDataSampleData(barWidth: barWidth);
  }

  void barTouchCallBack(BarTouchResponse barTouchResponse) {
    setState(() {
      if (barTouchResponse.spot != null &&
          barTouchResponse.touchInput is! FlPanEnd &&
          barTouchResponse.touchInput is! FlLongPressEnd) {
        sample.touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
      } else {
        sample.touchedIndex = -1;
      }
    });
  }

  BarChartDataSampleData sample;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
            child: ChartTitle(
              data: sample.mainBarData(barTouchCallBack),
              title: 'Bar graph title',
              subTitle: 'Bar graph subtext',
            ),
          ),
        ],
      ),
    );
  }
}
