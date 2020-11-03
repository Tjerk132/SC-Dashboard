import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/enums/line_chart_type.dart';
import 'package:flutter_test_project/models/charts/chart_appearance/line_chart_appearance_data.dart';
import 'package:flutter_test_project/models/charts/chart_data.dart';
import 'package:flutter_test_project/models/charts/line_chart/line_spots.dart';
import '../chart.dart';
import 'package:flutter_test_project/utility/utility.dart';

import 'line_charts.dart';

class LineChartGraph extends Chart {
  final double lineWidth;
  final int lineCount;
  final Map<int, String> leftTitles;
  final Map<int, String> bottomTitles;

  final Map<int, List<FlSpot>> mainDataSpots;
  final Map<int, List<FlSpot>> otherDataSpots;

  final Map<int, Color> mainDataColors;
  final Map<int, Color> otherDataColors;

  final LineChartAppearanceData data;

  @protected
  LineChartGraph({
    int singularSize,
    this.lineWidth = 8,
    this.lineCount = 3,
    this.leftTitles = const {},
    this.bottomTitles = const {},
    this.mainDataSpots = const {},
    this.otherDataSpots = const {},
    this.mainDataColors = const {},
    this.otherDataColors = const {},
  })  : data = LineChartAppearanceData(
          type: LineChartType.sales,
          singularSize: singularSize,
        ),
        super(type: ChartType.LineChart);

  factory LineChartGraph.fromJson(Map<String, dynamic> json,
      {@required int singularSize}) {
    return new LineChartGraph(
      singularSize: singularSize,
      lineCount: json["lineCount"] as int,
      leftTitles: {
        for (MapEntry<String, String> entry
        in (json["leftTitles"] as Map<dynamic, dynamic>).cast<String, String>().entries)
          int.parse(entry.key): entry.value,
      },
      bottomTitles: {
        for (MapEntry<String, String> entry
        in (json["bottomTitles"] as Map<dynamic, dynamic>).cast<String, String>().entries)
          int.parse(entry.key): entry.value,
      },
      mainDataSpots: {
        for (MapEntry<String, List<dynamic>> entry
        in (json["mainDataSpots"] as Map<dynamic, dynamic>).cast<String, List<dynamic>>().entries)
          int.parse(entry.key): LineSpots.fromJson(entry.value).spots,
      },
      otherDataSpots: {
        for (MapEntry<String, List<dynamic>> entry
        in (json["otherDataSpots"] as Map<dynamic, dynamic>).cast<String, List<dynamic>>().entries)
          int.parse(entry.key): LineSpots.fromJson(entry.value).spots,
      },
      mainDataColors: {
        for (MapEntry<String, String> entry
        in (json["mainDataColors"] as Map<dynamic, dynamic>).cast<String, String>().entries)
          int.parse(entry.key): JsonColor(entry.value),
      },
      otherDataColors: {
        for (MapEntry<String, String> entry
        in (json["otherDataColors"] as Map<dynamic, dynamic>).cast<String, String>().entries)
          int.parse(entry.key): JsonColor(entry.value),
      },
    );
  }

  @override
  State<LineChartGraph> createState() => LineChartGraphState();
}

class LineChartGraphState extends State<LineChartGraph> {
  LineCharts charts;
  bool isShowingMainData = true;

  @override
  void initState() {
    super.initState();
    charts = LineCharts(widget.lineWidth, widget.lineCount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AspectRatio(
        aspectRatio: 1.23,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            gradient: widget.data.backgroundGradient,
          ),
          child: Stack(
            children: <Widget>[
              //for stocks only
              AspectRatio(
                aspectRatio: widget.data.aspectRatio,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 4.0,
                      left: 4.0,
                      top: 4,
                      bottom: 4,
                    ),
                    child: ChartData(
                      data: LineChart(
                        isShowingMainData
                            ? charts.mainDataGraph(
                                widget.data.mainMinX,
                                widget.data.mainMaxX,
                                widget.data.mainMaxY,
                                widget.data.mainMinY,
                                widget.leftTitles,
                                widget.bottomTitles,
                                widget.mainDataSpots,
                                widget.mainDataColors,
                              )
                            : charts.otherDataGraph(
                                widget.data.otherMinX,
                                widget.data.otherMaxX,
                                widget.data.otherMaxY,
                                widget.data.otherMinY,
                                widget.leftTitles,
                                widget.bottomTitles,
                                widget.otherDataSpots,
                                widget.otherDataColors,
                              ),
                      ),
                      title: 'Parcours',
                      subTitle: 'Laatst gespeelde spel',
                    ),
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: IconButton(
              //     alignment: Alignment.topLeft,
              //     icon: Icon(
              //       Icons.refresh,
              //       color:
              //           Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              //     ),
              //     onPressed: () {
              //       setState(() {
              //         isShowingMainData = !isShowingMainData;
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
