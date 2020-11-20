import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';

abstract class Chart extends StatefulWidget {
  final ChartType type;
  final String title;
  final String subTitle;
  //yyyy-mm-dd
  final DateTime date;
  Chart({
    Key key,
    this.type,
    this.title,
    this.subTitle,
    this.date,
  }) : super(key: key);

}
