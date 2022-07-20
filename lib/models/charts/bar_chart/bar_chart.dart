import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/app/locator.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/models/charts/base_chart_data/basic_bar_chart_data.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/charts/chart_appearance/bar_chart_appearance_data.dart';
import 'package:flutter_test_project/models/charts/chart_components/chart_data.dart';
import 'package:flutter_test_project/models/theme_scheme.dart';
import 'package:flutter_test_project/services/group_type_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bar_chart.g.dart';

@JsonSerializable(explicitToJson: true)
class BarChartGraph extends Chart {
  final List<double> barValues;
  final List<String> barTouchTooltipData;

  BarChartGraph({
    required String title,
    String? subTitle,
    this.barValues = const [],
    this.barTouchTooltipData = const [],
  }) : super(
          type: ChartType.BarChart,
          title: title,
          subtitle: subTitle,
        );

  factory BarChartGraph.fromJson(Map<String, dynamic> json) =>
      _$BarChartGraphFromJson(json);

  String toJson() => jsonEncode(_$BarChartGraphToJson(this));

  @override
  State<BarChartGraph> createState() => BarChartGraphState();
}

class BarChartGraphState extends State<BarChartGraph> {
  final GroupTypeService _groupTypeService = locator<GroupTypeService>();

  BarChartAppearanceData get appearanceData => new BarChartAppearanceData(
        factor: _groupTypeService.getByChart(widget).factor,
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: ChartData(
            data: BarChart(
              BasicBarChartData(
                barTouchTooltipData: widget.barTouchTooltipData,
                barValues: widget.barValues,
                barWidth: appearanceData.barWidth,
                factor: appearanceData.factor,
                rodCount: 1,
                rodColor: ThemeScheme.accentColor,
                rodBackgroundColor: ThemeScheme.accentColor.withOpacity(0.5),
                gridData: FlGridData(show: false),
                titlesTextStyle: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                toolTipStyle: TextStyle(
                  color: Colors.yellow,
                ),
                toolTipBgColor: Colors.blueGrey,
              ),
            ),
            title: widget.title,
            subtitle: widget.subtitle,
          ),
        ),
      ],
    );
  }
}
