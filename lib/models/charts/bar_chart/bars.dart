import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart_data.dart';
import 'package:flutter_test_project/utility/utility.dart';

import 'bar.dart';

class Bars extends StatefulWidget {
  final String title;
  final String subTitle;

  final double barWidth;
  final int barCount;
  final int touchedIndex;
  final List<double> barValues;
  final List<String> barTouchTooltipData;
  final Function(BarTouchResponse) barTouchCallBack;

  Bars({
    Key key,
    this.title,
    this.subTitle,
    this.barWidth,
    this.barCount = 5,
    this.touchedIndex = -1,
    this.barValues = const [],
    this.barTouchTooltipData = const [],
    this.barTouchCallBack,
  }) : super(key: key);

  @override
  _BarsState createState() => _BarsState();
}

class _BarsState extends State<Bars> {
  @override
  Widget build(BuildContext context) {
    return ChartData(
      title: widget.title,
      subTitle: widget.subTitle,
      data: BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.blueGrey,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                int x = group.x.toInt();
                String tooltip = widget.barTouchTooltipData[x];
                return BarTooltipItem(
                  '$tooltip\n${rod.y - 1}',
                  TextStyle(color: Colors.yellow),
                );
              }),
          touchCallback: (barTouchResponse) =>
              widget.barTouchCallBack(barTouchResponse),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            margin: 16,
            getTitles: (double value) {
              int iValue = value.toInt();
              String day = widget.barTouchTooltipData.getOrElse(iValue, '');
              return day.substring(0, 1);
            },
          ),
          leftTitles: SideTitles(
            showTitles: false,
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: List<Bar>.generate(
          widget.barCount,
          (i) => Bar(
            i,
            widget.barValues.getOrElse(i, null),
            isTouched: i == widget.touchedIndex,
            width: widget.barWidth,
          ),
        ),
      ),
    );
  }
}
