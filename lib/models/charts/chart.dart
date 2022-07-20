import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';

abstract class Chart extends StatefulWidget {
  final ChartType type;
  final String title;
  final String? subtitle;

  @mustCallSuper
  Chart({
    Key? key,
    required this.type,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  factory Chart.fromJson(Map<String, dynamic> json) {
    ChartType type = ChartType.values.firstWhere(
        (e) => describeEnum(e) == json['type'],
        orElse: () => ChartType.TextChart);

    return type.instance(json);
  }

  String toJson();
}
