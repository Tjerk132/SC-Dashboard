import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/app/locator.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/enums/pie_chart_type.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/models/charts/chart_appearance/pie_chart_appearance_data.dart';
import 'package:flutter_test_project/models/charts/pie_chart/center_progress_indicator.dart';
import 'package:flutter_test_project/models/charts/pie_chart/indicators.dart';
import 'package:flutter_test_project/models/theme_scheme.dart';
import 'package:flutter_test_project/services/group_type_service.dart';
import 'package:flutter_test_project/utility/utility.dart';
import '../chart.dart';
import '../chart_components/chart_data.dart';
import '../base_chart_data/basic_pie_chart_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pie_chart.g.dart';

@JsonSerializable(explicitToJson: true)
class PieChartGraph extends Chart {
  final List<double> values;
  final List<String> indicatorText;
  @JsonKey(fromJson: _colorsFromJson, toJson: _colorsToJson)
  final List<Color> sectionColors;

  final PieChartType pieChartType;

  static _colorsFromJson(List<dynamic> colors) {
    return colors.castTo<Color>(
      getValue: (value) => HexColor.fromHex(value),
    );
  }

  static _colorsToJson(List<Color> colors) {
    return colors.map((c) => c.toHex()).toList();
  }

  PieChartGraph({
    required String title,
    required List<Color> sectionColors,
    required this.pieChartType,
    this.values = const [],
    this.indicatorText = const [],
  })  : sectionColors = sectionColors.isEmpty ? ThemeScheme.chartPalette : sectionColors,
        super(
          type: ChartType.PieChart,
          title: title,
        );

  @override
  factory PieChartGraph.fromJson(Map<String, dynamic> json) =>
      _$PieChartGraphFromJson(json);

  @override
  String toJson() => jsonEncode(_$PieChartGraphToJson(this));

  @override
  State<PieChartGraph> createState() => PieChartGraphState();
}

class PieChartGraphState extends State<PieChartGraph> {
  final GroupTypeService _groupTypeService = locator<GroupTypeService>();

  PieChartAppearanceData get appearanceData => new PieChartAppearanceData(
        type: widget.pieChartType,
        factor: _groupTypeService.getByChart(widget).factor,
      );

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: appearanceData.axis,
      children: <Widget>[
        Indicators(
          indicatorSize: appearanceData.indicatorSize,
          fontSize: appearanceData.fontSize,
          type: appearanceData.type,
          indicatorText: widget.indicatorText,
          sectionColors: widget.sectionColors,
          title: widget.title,
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ChartData(
                  data: PieChart(
                    BasicPieChartData(
                      sectionColors: widget.sectionColors,
                      values: widget.values,
                      pieRadius: appearanceData.pieRadius,
                      fontSize: appearanceData.fontSize,
                      showPieTitle: appearanceData.showTitle,
                      sectionsSpace: appearanceData.sectionSpace,
                      centerSpaceRadius: appearanceData.centerSpaceRadius,
                      startDegreeOffset: appearanceData.startDegreeOffset,
                    ),
                  ),
                  showTitle: false,
                ),
                appearanceData.centerProgressIndicator
                    ? CenterProgressIndicator(
                        title: widget.title,
                        type: appearanceData.type,
                        value: widget.values[0],
                        style: TextStyle(
                          fontSize: appearanceData.fontSize * 2,
                          // color: widget.sectionColors[0],
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
