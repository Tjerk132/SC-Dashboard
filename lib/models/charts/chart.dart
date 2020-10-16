import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

abstract class Chart extends StatefulWidget {

  const Chart();

  @override
  State<Chart> createState();

  static int length = ChartType.values.length;

  factory Chart.byType(ChartType type, TileGroup group) {
    return type.instance(group.singularSize);
  }

  static List<ChartType> types() => [
    for (int i = 0; i < length; i++)
        ChartType.values[i]
  ];

}
