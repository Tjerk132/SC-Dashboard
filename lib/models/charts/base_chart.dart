import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/utility/utility.dart';
import 'bar_chart/bar.dart';
import 'line_chart/line.dart';

class BaseChart {
  BarTouchData baseTouchData(List<String> barTouchTooltipData,
      Function(BarTouchResponse) barTouchCallBack) {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            int x = group.x.toInt();
            String tooltip = barTouchTooltipData[x];
            return BarTooltipItem(
              '$tooltip\n${rod.y - 1}',
              TextStyle(color: Colors.yellow),
            );
          }),
      touchCallback: (barTouchResponse) => barTouchCallBack(barTouchResponse),
    );
  }

  FlTitlesData baseTitleData(
      {@required bool showTitles,
      String Function(double) getTitlesBottom,
      String Function(double) getTitlesLeft,
      bool showBottomTitles,
      bool showLeftTitles}) {
    return FlTitlesData(
      show: showTitles,
      bottomTitles: showBottomTitles
          ? SideTitles(
              showTitles: true,
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              margin: 16,
              getTitles: getTitlesBottom,
            )
          : SideTitles(
              showTitles: false,
            ),
      leftTitles: showLeftTitles
          ? SideTitles(
              showTitles: true,
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              margin: 16,
              getTitles: getTitlesLeft,
            )
          : SideTitles(
              showTitles: false,
            ),
    );
  }

  List<BarChartGroupData> baseBarGroups(
      int barCount, List<double> barValues, int touchedIndex, double barWidth) {
    return List<Bar>.generate(
      barCount,
      (i) => Bar(
        i,
        barValues.getOrElse(i, null),
        isTouched: i == touchedIndex,
        width: barWidth,
      ),
    );
  }

  List<LineChartBarData> baseLineGroups(int lineCount,
      Map<int, List<FlSpot>> spots, Map<int, Color> colors, double lineWidth) {
    return List<Line>.generate(
      lineCount,
      (index) => Line(
        spots: spots[index],
        isCurved: true,
        colors: [colors[index]],
        barWidth: lineWidth,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          //for purple only
          colors: [const Color(0x00aa4cfc)],
        ),
      ),
    );
  }
}
