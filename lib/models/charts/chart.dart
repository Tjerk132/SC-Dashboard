import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';

abstract class Chart extends StatefulWidget {
  Chart(this.index);

  @override
  State<StatefulWidget> createState();
1
  final int index;

  // final ChartType type;

  static int count = ChartType.values.length;

  static Map<ChartType, Chart> types(List<int> indexes) {
    return {
      for (ChartType type in ChartType.values.toList())
        type: type.instance(indexes[ChartType.values.indexOf(type)])
    };
  }
}
