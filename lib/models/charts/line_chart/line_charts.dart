import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Tjerk_2/Desktop/Flutter-TestApp/lib/models/charts/base_chart_data/basic_line_chart_data.dart';

class LineCharts {
  LineCharts(this.lineWidth, this.lineCount);

  final double lineWidth;
  final int lineCount;

  BasicLineChartData mainDataGraph(
    double minX,
    double maxX,
    double maxY,
    double minY,
    Map<int, String> leftTitles,
    Map<int, String> bottomTitles,
    Map<int, List<FlSpot>> spots,
    Map<int, Color> colors,
  ) {
    // minX= 0;
    // maxX= 11;
    // minY= 0;
    // maxY= 6;

    return BasicLineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),

      // gridData: FlGridData(
      //   show: true,
      //   drawVerticalLine: true,
      //   getDrawingHorizontalLine: (value) {
      //     return FlLine(
      //       color: const Color(0xff37434d),
      //       strokeWidth: 1,
      //     );
      //   },
      //   getDrawingVerticalLine: (value) {
      //     return FlLine(
      //       color: const Color(0xff37434d),
      //       strokeWidth: 1,
      //     );
      //   },
      // ),
      // reservedSize: 22,
      // borderData: FlBorderData(
      //     show: true,
      //     border: Border.all(color: const Color(0xff37434d), width: 1)),
      // margin: 8,

      bottomTitles: bottomTitles,
      leftTitles: leftTitles,
      minX: minX,
      maxX: maxX,
      maxY: maxY,
      minY: minY,
      // minX: 0,
      // maxX: 11,
      // minY: 0,
      // maxY: 6,
      lineCount: lineCount,
      spots: spots,
      colors: colors,
      lineWidth: lineWidth,
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 2),
          left: BorderSide(color: Color(0xff4e4965), width: 2),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }

  BasicLineChartData otherDataGraph(
    double minX,
    double maxX,
    double maxY,
    double minY,
    Map<int, String> leftTitles,
    Map<int, String> bottomTitles,
    Map<int, List<FlSpot>> spots,
    Map<int, Color> colors,
  ) {
    return BasicLineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),

      reservedSize: 22,
      //16 for sale 8 for stocks
      margin: 16,

      bottomTitles: bottomTitles,
      leftTitles: leftTitles,
      minX: minX,
      maxX: maxX,
      maxY: maxY,
      minY: minY,
      lineCount: lineCount,
      spots: spots,
      colors: colors,
      lineWidth: lineWidth,
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      textStyle: TextStyle(
        color: Colors.grey[200],
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }
}
