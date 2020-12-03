import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:json_annotation/json_annotation.dart';
import '../chart.dart';

part 'text_chart.g.dart';

@JsonSerializable(explicitToJson: true)
class TextChart extends Chart {
  final String content;

  TextChart({
    String title,
    this.content,
    DateTime date,
  }) : super(
          type: TileGroupType.Text,
          title: title,
          date: date,
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
    return Column(
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.content,
            style: TextStyle(fontSize: 20.0),
          ),
        )
      ],
    );
  }
}
