import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';

abstract class Chart extends StatefulWidget {
  final ChartType type;

  Chart({
    Key key,
    this.type,
  }) : super(key: key);
}
