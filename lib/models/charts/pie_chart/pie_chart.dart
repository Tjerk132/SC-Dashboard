import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/enums/pie_chart_type.dart';
import 'package:flutter_test_project/models/charts/chart_appearance/pie_chart_appearance_data.dart';
import 'package:flutter_test_project/models/charts/pie_chart/center_progress_indicator.dart';
import 'package:flutter_test_project/models/charts/pie_chart/indicators.dart';
import 'package:flutter_test_project/models/theme_scheme.dart';
import '../chart.dart';
import 'package:flutter_test_project/utility/utility.dart';

import '../chart_data.dart';
import '../base_chart_data/basic_pie_chart_data.dart';

class PieChartGraph extends Chart {
  final String title;
  final int pieCount;
  final List<double> values;
  final List<String> indicatorText;
  final List<Color> sectionColors;

  //determines the appearance of the chart (switch between the fl pie chart samples)
  final PieChartAppearanceData data;

  @protected
  PieChartGraph({
    int singularSize,
    PieChartType type,
    this.title,
    this.pieCount = 3,
    this.values = const [],
    this.indicatorText = const [],
    List<Color> sectionColors,
  })  : sectionColors = sectionColors.isEmpty
          ? ThemeScheme.chartPalette
          : sectionColors,
        data = PieChartAppearanceData(
          type: type,
          singularSize: singularSize,
        ),
        super(type: ChartType.PieChart);

  factory PieChartGraph.fromJson(
    Map<String, dynamic> json, {
    @required int singularSize,
    @required PieChartType type,
  }) {
    return new PieChartGraph(
      indicatorText: (json["indicatorText"] as List).cast<String>(),
      sectionColors: (json["sectionColors"] as List).castTo<Color>(
        getValue: (value) => HexColor.fromHex(value),
      ),
      values: (json["values"] as List).cast<double>(),
      pieCount: json["pieCount"] as int,
      singularSize: singularSize,
      type: type,
      title: json["title"],
    );
  }

  @override
  State<PieChartGraph> createState() => PieChartGraphState();
}

class PieChartGraphState extends State<PieChartGraph> {
  int touchedIndex;

  void pieTouchCallback(PieTouchResponse pieTouchResponse) {
    setState(() {
      if (pieTouchResponse.touchInput is FlLongPressEnd ||
          pieTouchResponse.touchInput is FlPanEnd) {
        touchedIndex = -1;
      } else {
        touchedIndex = pieTouchResponse.touchedSectionIndex;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: widget.data.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Flex(
          direction: widget.data.axis,
          children: <Widget>[
            const SizedBox(
              height: 2,
            ),
            Indicators(
              indicatorSize: widget.data.indicatorSize,
              fontSize: widget.data.fontSize,
              type: widget.data.type,
              pieCount: widget.pieCount,
              indicatorText: widget.indicatorText,
              sectionColors: widget.sectionColors,
              touchedIndex: touchedIndex,
              title: widget.title,
            ),
            const SizedBox(
              height: 2,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: <Widget>[
                    ChartData(
                      showTitle: false,
                      data: PieChart(
                        BasicPieChartData(
                          pieCount: widget.pieCount,
                          sectionColors: widget.sectionColors,
                          values: widget.values,
                          touchedIndex: touchedIndex,
                          pieRadius: widget.data.pieRadius,
                          fontSize: widget.data.fontSize,
                          showPieTitle: widget.data.showPieTitle,
                          sectionsSpace: widget.data.sectionSpace,
                          centerSpaceRadius: widget.data.centerSpaceRadius,
                          pieTouchData: PieTouchData(
                            touchCallback: (pieTouchResponse) =>
                                pieTouchCallback(pieTouchResponse),
                          ),
                          startDegreeOffset: 180,
                          borderData: FlBorderData(
                            show: false,
                          ),
                        ),
                      ),
                    ),
                    widget.data.centerProgressIndicator
                        ? CenterProgressIndicator(
                            value: widget.values[0],
                            fontSize: widget.data.fontSize * 2,
                            color: widget.sectionColors[0],
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
