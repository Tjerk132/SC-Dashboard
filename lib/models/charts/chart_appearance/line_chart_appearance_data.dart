import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/line_chart_type.dart';

class LineChartAppearanceData {
  LineChartType type;
  double aspectRatio;
  FlGridData gridData;
  TextStyle textStyle;
  Gradient backgroundGradient;
  Color backgroundColor;

  double mainMinX;
  double mainMaxX;
  double mainMaxY;
  double mainMinY;

  double otherMinX;
  double otherMaxX;
  double otherMaxY;
  double otherMinY;

  LineChartAppearanceData({
    @required this.type,
    int singularSize,
  }) {
    mainMinX = 0;
    mainMaxX = 14;
    mainMaxY = 4;
    mainMinY = 0;

    otherMinX = 0;
    otherMaxX = 14;
    otherMaxY = 0;
    otherMinY = 6;
    switch (this.type) {
      case LineChartType.sales:
        gridData = FlGridData(show: false);
        textStyle = TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        );
        backgroundGradient = LinearGradient(
          colors: [
            // ThemeScheme.primaryGradientColor,
            Colors.white,
            Colors.white,
            // Color(0xff2c274c),
            // Color(0xff46426c),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        );
        backgroundColor = Color(0xffffffff);
        break;
      case LineChartType.stocks:
        gridData = FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.black,
              // const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.black,
              // const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        );
        textStyle = TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        );
        backgroundGradient = LinearGradient(
          colors: [
            // ThemeScheme.primaryGradientColor,
            Colors.white,
            Colors.white,
            // Color(0xff232d37),
            // Color(0xff232d41),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        );
        backgroundColor = Color(0xfff9b34a);
        break;
      default:
        break;
    }
    if (singularSize == 2) {
      this.aspectRatio = 2;
    }
    else
      aspectRatio = 1;
  }
}
