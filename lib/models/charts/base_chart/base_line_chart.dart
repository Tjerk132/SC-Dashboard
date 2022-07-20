import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/base_chart/base_chart.dart';
import 'package:flutter_test_project/utility/utility.dart';

class BaseLineChart with BaseChart {
  List<LineChartBarData> lineGroups(
    Map<int, List<FlSpot>> spots,
    Color color,
    double lineWidth, {
    bool? showBelowBarData = false,
    Color? belowBarColor,
  }) {
    return List<LineChartBarData>.generate(
      spots.length,
      (i) => LineChartBarData(
        spots: spots[i],
        isCurved: true,
        color: color,
        barWidth: lineWidth,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: showBelowBarData,
          color: belowBarColor ??
              ColorTween(begin: Color(0xff23b6e6), end: Color(0xff02d39a))
                  .lerp(0.2)
                  ?.withOpacity(0.1),
        ),
      ),
    );
  }

  //only creates tooltipIndicator for first line
  List<ShowingTooltipIndicators> tooltipIndicators(
    Map<int, List<FlSpot>> spots, {
    Color color = Colors.white,
    List<int> showIndexes = const [1, 3, 5],
  }) {
    List<LineChartBarData> lineBarsData =
        createLineBarsData(spots[0]!, showIndexes, color: color);

    final LineChartBarData tooltipsOnBar = lineBarsData[0];

    return showIndexes
        .map(
          (i) => ShowingTooltipIndicators(
            <LineBarSpot>[
              LineBarSpot(
                tooltipsOnBar,
                lineBarsData.indexOf(tooltipsOnBar),
                tooltipsOnBar.spots[i],
              ),
            ],
          ),
        )
        .toList();
  }

  List<LineChartBarData> createLineBarsData(
    List<FlSpot> spots,
    List<int> showingIndicators, {
    Color? color,
  }) {
    return List<LineChartBarData>.generate(
      1,
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
        color: color,
        // colors: [
        //   Color(0xff12c2e9),
        //   Color(0xffc471ed),
        //   Color(0xfff64f59),
        // ],
        // colorStops: [3.1, 5.4, 8.9],
      ),
    );
  }

  LineTouchData lineTouchData({
    Color? color = Colors.black,
  }) {
    return LineTouchData(
      enabled: false,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.transparent,
        tooltipMargin: 1.0,
        // tooltipBottomMargin: 1,
        getTooltipItems: (List<LineBarSpot> touchedSpots) {
          return touchedSpots
              .map((spot) => LineTooltipItem(
                    (spot.y).toStringAsFixed(1),
                    TextStyle(color: color),
                  ))
              .toList();
        },
      ),
    );
  }
}
