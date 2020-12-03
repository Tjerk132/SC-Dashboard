import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/pie_chart_type.dart';

///this class is used to get the corresponding data for the
///given [PieChartType] and to make it possible to switch
///between types easily
class PieChartAppearanceData {

  PieChartType type;
  double pieRadius;
  Axis axis;
  double sectionSpace;
  double centerSpaceRadius;
  bool showPieTitle;
  bool centerProgressIndicator;
  double indicatorSize;
  double fontSize;

  PieChartAppearanceData({
    @required this.type,
    int singularSize,
  }) {
    double factor = 6.5;
    switch (this.type) {
      case PieChartType.donut:
        this.pieRadius = 32 + (4.0 * singularSize);
        this.axis = Axis.horizontal;
        this.sectionSpace = 0;
        this.centerSpaceRadius = singularSize * 18.0;
        this.showPieTitle = true;
        this.centerProgressIndicator = false;
        this.indicatorSize = 11 + (singularSize * 3.0);
        this.fontSize = 11.0 + singularSize;
        break;

      case PieChartType.divided:
        this.pieRadius = (1 + singularSize) * (factor * 3.5);
        this.axis = Axis.vertical;
        this.sectionSpace = 8.0 + singularSize;
        this.centerSpaceRadius = 12;
        this.showPieTitle = true;
        this.centerProgressIndicator = false;
        this.indicatorSize = 11 + (singularSize * 3.0);
        this.fontSize = 10.0 + singularSize;
        break;

      case PieChartType.circle:
        this.pieRadius = (0.7 + singularSize) * (factor * 4.0);
        this.axis = Axis.horizontal;
        this.sectionSpace = 0;
        this.centerSpaceRadius = 0;
        this.showPieTitle = false;
        this.centerProgressIndicator = false;
        this.indicatorSize = 11 + (singularSize * 3.0);
        this.fontSize = 12.0 + singularSize;
        break;

      case PieChartType.progression:
        this.pieRadius = 10.0 * singularSize;
        this.axis = Axis.vertical;
        this.sectionSpace = 0;
        this.centerSpaceRadius = 50 + (singularSize * 4.0);
        this.showPieTitle = false;
        this.centerProgressIndicator = true;
        this.indicatorSize = 11 + (singularSize * 3.0);
        this.fontSize = 10.0 + (2 * singularSize);
        break;

      default:
        break;
    }
  }
}
