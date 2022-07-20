import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/app/locator.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/models/charts/base_chart_data/basic_line_chart_data.dart';
import 'package:flutter_test_project/models/charts/chart_appearance/line_chart_appearance_data.dart';
import 'package:flutter_test_project/models/charts/chart_components/chart_data.dart';
import 'package:flutter_test_project/models/theme_scheme.dart';
import 'package:flutter_test_project/services/group_type_service.dart';
import '../chart.dart';
import 'package:flutter_test_project/utility/utility.dart';
import 'package:json_annotation/json_annotation.dart';

part 'line_chart.g.dart';

@JsonSerializable(explicitToJson: true)
class LineChartGraph extends Chart {
  final double lineWidth;

  final Map<int, String> topTitles;
  final Map<int, String> bottomTitles;
  final Map<int, String> leftTitles;
  final Map<int, String> rightTitles;

  @JsonKey(fromJson: _spotsFromJson, toJson: _spotsToJson)
  final Map<int, List<FlSpot>> spots;
  @JsonKey(fromJson: _colorsFromJson, toJson: _colorsToJson)
  final Color color;

  static _spotsFromJson(Map<String, dynamic> spots) {
    return spots.castTo<int, List<FlSpot>>(
      // the to be converted array looks like: [ [1,1], [2,1.5] etc. ]
      getValue: (value) {
        List<FlSpot> spots = <FlSpot>[];
        for (List<dynamic> spotCoordinates in value) {
          List<double> coordinates =
              spotCoordinates.map<double>((e) => e.toDouble()).toList();
          spots.add(FlSpot(coordinates[0], coordinates[1]));
        }
        return spots;
      },
    );
  }

  static _spotsToJson(Map<int, List<FlSpot>> spots) {
    return spots.map(
      (k, e) => MapEntry(
        k.toString(),
        e.map((e) => [e.x, e.y]).toList(),
      ),
    );
  }

  static _colorsFromJson(dynamic color) => HexColor.fromHex(color);

  // return colors?.castTo<int, Color>(
  //   getValue: (value) => HexColor.fromHex(value),
  // );

  static _colorsToJson(Color color) => color.toHex();

  // return colors?.map(
  //   (k, e) => MapEntry(
  //     k.toString(),
  //     e.toHex(),
  //   ),
  // );

  LineChartGraph({
    required String title,
    String? subTitle,
    this.lineWidth = 8,
    this.topTitles = const {},
    this.bottomTitles = const {},
    this.leftTitles = const {},
    this.rightTitles = const {},
    this.spots = const {},
    Color? color,
  })  : color = color ?? ThemeScheme.primaryColor,
        super(
          type: ChartType.LineChart,
          title: title,
          subtitle: subTitle,
        );

  @override
  factory LineChartGraph.fromJson(Map<String, dynamic> json) =>
      _$LineChartGraphFromJson(json);

  @override
  String toJson() => jsonEncode(_$LineChartGraphToJson(this));

  @override
  State<LineChartGraph> createState() => LineChartGraphState();
}

class LineChartGraphState extends State<LineChartGraph> {
  final GroupTypeService _groupTypeService = locator<GroupTypeService>();

  LineChartAppearanceData get appearanceData => new LineChartAppearanceData(
        factor: _groupTypeService.getByChart(widget).factor,
      );

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.13,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            //for stocks only
            AspectRatio(
              aspectRatio: appearanceData.aspectRatio,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                child: ChartData(
                  data: LineChart(
                    BasicLineChartData(
                      gridData: FlGridData(
                        show: false,
                      ),
                      reservedSize: 22,
                      margin: 1,
                      topTitles: widget.topTitles,
                      bottomTitles: widget.bottomTitles,
                      leftTitles: widget.leftTitles,
                      rightTitles: widget.rightTitles,
                      minX: 0,
                      maxX: 14,
                      minY: 0,
                      maxY: 4,
                      spots: widget.spots,
                      color: widget.color,
                      lineWidth: widget.lineWidth,
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(color: Colors.black, width: 2),
                          left: BorderSide(color: Colors.black, width: 2),
                          right: BorderSide(color: Colors.transparent),
                          top: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  title: widget.title,
                  subtitle: widget.subtitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
