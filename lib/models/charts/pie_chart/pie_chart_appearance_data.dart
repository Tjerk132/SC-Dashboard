import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/pie_chart_appearance.dart';

class PieChartAppearanceData {
  final PieChartType appearance;
  Axis axis;
  double sectionSpace;
  double centerSpaceRadius;
  bool showPieTitleColorAsPieColor;

  PieChartAppearanceData({
    @required this.appearance,
  }) {
    switch (this.appearance) {
      case PieChartType.donut:
        this.axis = Axis.horizontal;
        this.sectionSpace = 0;
        this.centerSpaceRadius = 40;
        this.showPieTitleColorAsPieColor = false;
        break;

      case PieChartType.rectangular:
        this.axis = Axis.vertical;
        this.sectionSpace = 12;
        this.centerSpaceRadius = 0;
        this.showPieTitleColorAsPieColor = true;
        break;

      case PieChartType.circular:
        this.axis = Axis.horizontal;
        this.sectionSpace = 0;
        this.centerSpaceRadius = 0;
        this.showPieTitleColorAsPieColor = false;
        break;

      default:
        break;
    }
  }
}
