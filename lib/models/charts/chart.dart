import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

abstract class Chart extends StatefulWidget {
  const Chart();

  @override
  State<Chart> createState();

  static final int length = ChartType.values.length;

  static List<ChartType> types() =>
  [
    for (int i = 0; i < length; i++)
      ChartType.values[i]
  ];

  // return the chart by the given tileGroup
  static Future<Chart> byGroup(BuildContext context, TileGroup group) {
    return group.type.instance(context, group.singularSize);
  }
}
