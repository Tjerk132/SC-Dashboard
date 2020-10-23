import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Tjerk_2/Desktop/Flutter-TestApp/lib/models/charts/pie_chart/indicator.dart';
import 'package:flutter_test_project/models/charts/pie_chart/pie.dart';
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

  FlTitlesData baseTitleData({
    @required bool show,
    @required TextStyle textStyle,
    double margin = 16,
    String Function(double) getTitlesTop,
    String Function(double) getTitlesBottom,
    String Function(double) getTitlesLeft,
    String Function(double) getTitlesRight,
  }) {
    bool showTop = getTitlesTop != null;
    bool showBottom = getTitlesBottom != null;
    bool showLeft = getTitlesLeft != null;
    bool showRight = getTitlesRight != null;
    return FlTitlesData(
      show: show,
      topTitles: SideTitles(
        showTitles: showTop,
        textStyle: textStyle,
        margin: margin,
        getTitles: getTitlesTop,
      ),
      bottomTitles: SideTitles(
        showTitles: showBottom,
        textStyle: textStyle,
        margin: margin,
        getTitles: getTitlesBottom,
      ),
      leftTitles: SideTitles(
        showTitles: showLeft,
        textStyle: textStyle,
        margin: margin,
        getTitles: getTitlesLeft,
      ),
      rightTitles: SideTitles(
        showTitles: showRight,
        textStyle: textStyle,
        margin: margin,
        getTitles: getTitlesRight,
      ),
    );
  }

  List<BarChartGroupData> baseBarGroups(
      int count, List<double> barValues, int touchedIndex, double barWidth) {
    return List<Bar>.generate(
      count,
      (i) => Bar(
        i,
        barValues.getOrElse(i, null),
        isTouched: i == touchedIndex,
        width: barWidth,
      ),
    );
  }

  List<LineChartBarData> baseLineGroups(int count, Map<int, List<FlSpot>> spots,
      Map<int, Color> colors, double lineWidth) {
    return List<Line>.generate(
      count,
      (i) => Line(
        spots: spots[i],
        isCurved: true,
        colors: [colors[i]],
        barWidth: lineWidth,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          //todo should be for purple only
          colors: [const Color(0x00aa4cfc)],
        ),
      ),
    );
  }

  List<Pie> basePieGroups(int count, List<Color> sectionColors,
      int touchedIndex, double pieRadius, List<double> values) {
    return List<Pie>.generate(
      count,
      (i) => Pie(
        color: sectionColors[i],
        isTouched: i == touchedIndex,
        value: values[i],
        pieRadius: pieRadius,
      ),
    );
  }
}
