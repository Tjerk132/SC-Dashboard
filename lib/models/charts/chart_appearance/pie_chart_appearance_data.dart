import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/pie_chart_type.dart';

///this class is used to get the corresponding data for the
///given [PieChartType] and to make it possible to switch
///between types easily
class PieChartAppearanceData {

  final PieChartType type;
  late double pieRadius;
  late Axis axis;
  late double centerSpaceRadius;
  late double startDegreeOffset;
  late double indicatorSize;
  late double fontSize;

  bool get showTitle => type.showTitle;

  bool get centerProgressIndicator => type.centerProgressIndicator;

  double get sectionSpace => type.sectionSpace;

  PieChartAppearanceData({
    required this.type,
    required int factor,
  }) {
    indicatorSize = 11 + (factor * 3.0);
    fontSize = 12.0 + (2 * factor);

    switch (type) {
      case PieChartType.donut:
        pieRadius = 32 + (factor * 4);
        axis = Axis.horizontal;
        centerSpaceRadius = factor * 15.0;
        startDegreeOffset = 180;
        break;

      case PieChartType.divided:
        pieRadius = (factor * 3) * 12;
        axis = Axis.vertical;
        centerSpaceRadius = 10;
        startDegreeOffset = 180;
        break;

      case PieChartType.circle:
        pieRadius = (factor * 2) * 15;
        axis = Axis.horizontal;
        centerSpaceRadius = 0;
        startDegreeOffset = 180;
        break;

      case PieChartType.progression:
        pieRadius = (factor * 1.5) * 10;
        axis = Axis.vertical;
        centerSpaceRadius = 50 + (factor * 4.0);
        startDegreeOffset = 180;
        break;

      case PieChartType.gauge:
        pieRadius = (factor * 1.5) * 10;
        axis = Axis.vertical;
        centerSpaceRadius = 55 + (factor * 4.0);
        startDegreeOffset = 90;
        break;

      default:
        break;
    }
  }
}
