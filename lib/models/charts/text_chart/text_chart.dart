import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../chart.dart';

part 'text_chart.g.dart';

@JsonSerializable(explicitToJson: true)
class TextChart extends Chart {
  final String content;

  TextChart({
    required String title,
    required this.content,
  }) : super(
          type: ChartType.TextChart,
          title: title,
        );

  factory TextChart.fromJson(Map<String, dynamic> json) =>
      _$TextChartFromJson(json);

  String toJson() => jsonEncode(_$TextChartToJson(this));

  @override
  _TextChartState createState() => _TextChartState();
}

class _TextChartState extends State<TextChart> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.content,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        );
      },
      tablet: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.content,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        );
      },
    );
  }
}
