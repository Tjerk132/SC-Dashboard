import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_chart.dart';
import 'package:flutter_test_project/models/charts/line_chart/line.dart';

class BaseLineChart with BaseChart {
  List<LineChartBarData> baseLineGroups(
    int count,
    Map<int, List<FlSpot>> spots,
    Map<int, Color> colors,
    double lineWidth, {
    bool showBelowBarData = false,
    List<Color> belowBarColors,
  }) {
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
          show: showBelowBarData,
          colors: belowBarColors ??
              <Color>[
                ColorTween(begin: Color(0xff23b6e6), end: Color(0xff02d39a))
                    .lerp(0.2)
                    .withOpacity(0.1),
                ColorTween(begin: Color(0xff23b6e6), end: Color(0xff02d39a))
                    .lerp(0.2)
                    .withOpacity(0.1),
              ],
        ),
      ),
    );
  }

  //only creates tooltipIndicator for first line
  List<ShowingTooltipIndicators> tooltipIndicators(
    List<FlSpot> spots,
    Color indicatorColor, {
    List<int> showIndexes,
  }) {
    // List<FlSpot> lineSpots = spots[0];
    showIndexes = showIndexes ?? [1, spots.length ~/ 2, spots.length - 1];

    List<LineChartBarData> lineBarsData = createLineBarsData(spots, showIndexes, indicatorColor);
    // final LineChartBarData tooltipsOnBar = lineBarsData[0];

    return showIndexes
      .map(
        (i) => ShowingTooltipIndicators(i, <LineBarSpot>[
          LineBarSpot(lineBarsData[i], lineBarsData.indexOf(lineBarsData[i]),
              lineBarsData[i].spots[i]),
        ]),
      )
      .toList();
  }

  List<LineChartBarData> createLineBarsData(
    List<FlSpot> spots,
    List<int> showingIndicators,
    Color color,
  ) {
    return List<LineChartBarData>.generate(
      spots.length,
      (index) => LineChartBarData(
        showingIndicators: showingIndicators,
        spots: spots,
        isCurved: true,
        barWidth: 4,

        shadow: Shadow(
          blurRadius: 8,
          color: Colors.black,
        ),
        // belowBarData: BarAreaData(
        //   show: true,
        //   colors: [
        //     // Color(0xff12c2e9).withOpacity(0.4),
        //     // Color(0xffc471ed).withOpacity(0.4),
        //     // Color(0xfff64f59).withOpacity(0.4),
        //   ],
        // ),
        // dotData: FlDotData(show: false),
        colors: [color],
        // colors: [
        //   Color(0xff12c2e9),
        //   Color(0xffc471ed),
        //   Color(0xfff64f59),
        // ],
        // colorStops: [3.1, 5.4, 8.9],
      ),
    );
  }
}
