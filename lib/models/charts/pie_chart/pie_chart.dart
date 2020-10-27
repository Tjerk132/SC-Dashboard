import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/enums/pie_chart_appearance.dart';
import 'package:flutter_test_project/models/charts/pie_chart/indicators.dart';
import 'package:flutter_test_project/models/charts/pie_chart/pie_chart_appearance_data.dart';
import '../chart.dart';
import 'package:flutter_test_project/utility/utility.dart';

import '../chart_data.dart';
import 'basic_pie_chart_data.dart';

class PieChartGraph extends Chart {
  final double pieRadius;
  final int pieCount;
  final List<double> values;
  final List<String> indicatorText;
  final List<Color> sectionColors;
  //change appearance to change between the fl pie chart samples
  final PieChartAppearanceData appearanceData = PieChartAppearanceData(
    appearance: PieChartType.donut
  );

  PieChartGraph({
    this.pieRadius = 60,
    this.pieCount = 3,
    this.values = const [],
    this.indicatorText = const [],
    this.sectionColors = const [],
  }) : super(type: ChartType.PieChart);

  factory PieChartGraph.fromJson(Map<String, dynamic> json,
      {double pieRadius = 60.0}) {
    return new PieChartGraph(
      indicatorText: (json["indicatorText"] as List<dynamic>).cast<String>(),
      sectionColors: [
        for (String colorString in (json["sectionColors"] as List<dynamic>).cast<String>())
          JsonColor(colorString)
      ],
      values: (json["values"] as List<dynamic>).cast<double>(),
      pieRadius: pieRadius,
      pieCount: json["pieCount"] as int,
    );
  }

  @override
  State<PieChartGraph> createState() => PieChartGraphState();
}

class PieChartGraphState extends State<PieChartGraph> {
  int touchedIndex;

  void touchCallback(PieTouchResponse pieTouchResponse) {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Flex(
          direction: widget.appearanceData.axis,
          children: <Widget>[
            const SizedBox(
              height: 2,
            ),
            Indicators(
              type: widget.appearanceData.appearance,
              pieCount: widget.pieCount,
              pieRadius: widget.pieRadius,
              values: widget.values,
              indicatorText: widget.indicatorText,
              sectionColors: widget.sectionColors,
              touchedIndex: touchedIndex,
            ),
            const SizedBox(
              height: 2,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: ChartData(
                  showTitle: false,
                  data: PieChart(
                    BasicPieChartData(
                      showPieTitleColorAsPieColor: widget.appearanceData.showPieTitleColorAsPieColor,
                      sectionsSpace: widget.appearanceData.sectionSpace,
                      centerSpaceRadius: widget.appearanceData.centerSpaceRadius,
                      pieTouchData: PieTouchData(
                        touchCallback: (pieTouchResponse) =>
                            touchCallback(pieTouchResponse),
                      ),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      pieCount: widget.pieCount,
                      pieRadius: widget.pieRadius,
                      sectionColors: widget.sectionColors,
                      values: widget.values,
                      touchedIndex: touchedIndex,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
