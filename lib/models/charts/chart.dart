import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/utility/utility.dart';

abstract class Chart extends StatefulWidget {
  @override
  State<StatefulWidget> createState();

  // final ChartType type;

  static Map<ChartType, Chart> values = <ChartType, Chart>{
    for (ChartType type in ChartType.values.toList()) type: type.instance()
  };
}
