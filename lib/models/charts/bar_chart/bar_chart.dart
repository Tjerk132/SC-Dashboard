import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/models/charts/base_chart_data/basic_bar_chart_data.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/charts/chart_appearance/bar_chart_appearance_data.dart';
import 'package:flutter_test_project/models/charts/chart_data.dart';
import 'package:flutter_test_project/models/theme_scheme.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bar_chart.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class BarChartGraph extends Chart {
  final int barCount;
  final List<double> barValues;
  final List<String> barTouchTooltipData;

  @JsonKey(ignore: true)
  BarChartAppearanceData data;

  BarChartGraph({
    String title,
    String subTitle,
    DateTime date,
    this.barCount = 7,
    this.barValues = const [],
    this.barTouchTooltipData = const [],
  }) : super(
          type: ChartType.BarChart,
          title: title,
          subTitle: subTitle,
          date: date,
        );

  void init(int singularSize) {
    this.data = BarChartAppearanceData(
      singularSize: singularSize,
    );
  }

  factory BarChartGraph.fromJson(
    Map<String, dynamic> json, {
    int singularSize,
  }) {
    BarChartGraph graph = _$BarChartGraphFromJson(json);
    graph.init(singularSize);
    return graph;
  }

  String toJson() => jsonEncode(_$BarChartGraphToJson(this));

  @override
  State<BarChartGraph> createState() => BarChartGraphState();
}

class BarChartGraphState extends State<BarChartGraph> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Align(
          //   alignment: Alignment.topRight,
          //   child: IconButton(
          //     alignment: Alignment.topRight,
          //     icon: Icon(
          //       Icons.play_arrow,
          //       color: Colors.black.withOpacity(0.9),
          //     ),
          //     onPressed: () => print('No onPress implemented'),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ChartData(
              data: BarChart(
                BasicBarChartData(
                  getBottomTitle: (String title) => title,
                  barTouchTooltipData: widget.barTouchTooltipData,
                  barValues: widget.barValues,
                  barWidth: widget.data.barWidth,
                  barCount: widget.barCount,
                  singularSize: widget.data.singularSize,
                  rodCount: 1,
                  rodColor: ThemeScheme.accentColor,
                  rodBackgroundColor: ThemeScheme.accentColor.withOpacity(0.5),
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
              subTitle: widget.subTitle,
            ),
          ),
        ],
      ),
    );
  }
}
