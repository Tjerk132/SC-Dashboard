import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/line_chart_type.dart';

class LineChartAppearanceData {
  LineChartType type;
  double aspectRatio;
  Gradient backgroundGradient;
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
        backgroundGradient = LinearGradient(
          colors: const [
            Color(0xff2c274c),
            Color(0xff46426c),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        );
        break;
      case LineChartType.stocks:
        // mainMinX = 0;
        // mainMaxX = 11;
        // mainMaxY = 0;
        // mainMinY = 6;
        //
        // otherMinX = 0;
        // otherMaxX = 11;
        // otherMaxY = 0;
        // otherMinY = 6;
        backgroundGradient = LinearGradient(
          colors: const [
            Color(0xff232d37),
            Color(0xff232d41),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        );
        break;
      default:
        break;
    }
    if (singularSize == 2) {
      this.aspectRatio = 2;
    } else
      aspectRatio = 1;
  }
}
