import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/charts/chart_title.dart';

import 'chart_data/bar_chart_data_samples.dart';

class BarChartGraph extends Chart {

  @override
  State<StatefulWidget> createState() => BarChartGraphState();
}

class BarChartGraphState extends State<BarChartGraph> {

  BarChartGraphState() {
    sample = BarChartDataSampleData();
  }

  void barTouchCallBack(BarTouchResponse barTouchResponse) {
    setState(() {
      if (barTouchResponse.spot != null &&
          barTouchResponse.touchInput is! FlPanEnd &&
          barTouchResponse.touchInput is! FlLongPressEnd) {
        sample.touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
      }
      else {
        sample.touchedIndex = -1;
      }
    });
  }

  BarChartDataSampleData sample;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xff81e5cd),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: ChartTitle(
                data: sample.mainBarData(barTouchCallBack),
                title: 'Bar graph title',
                subTitle: 'Bar graph subtext',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: const Color(0xff0f4a3c),
                  ),
                  onPressed: () => print('No onPress implemented'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
