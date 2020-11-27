import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:json_serializable/json_serializable.dart';

// @JsonSerializable()
abstract class Chart extends StatefulWidget {
  final ChartType type;
  final String title;
  final String subTitle;
  final DateTime date;

  Chart({
    Key key,
    this.type,
    this.title,
    this.subTitle,
    this.date,
  }) : super(key: key);

}
