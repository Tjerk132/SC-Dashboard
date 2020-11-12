import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/enums/line_chart_type.dart';
import 'package:flutter_test_project/models/charts/chart_appearance/line_chart_appearance_data.dart';
import 'package:flutter_test_project/models/charts/chart_data.dart';
import 'package:flutter_test_project/models/charts/line_chart/line_spots.dart';
import 'package:flutter_test_project/models/theme_scheme.dart';
import '../chart.dart';
import 'package:flutter_test_project/utility/utility.dart';

import 'line_charts.dart';

class LineChartGraph extends Chart {
  final String title;
  final String subTitle;
  final double lineWidth;
  final int lineCount;

  final Map<int, String> topTitles;
  final Map<int, String> bottomTitles;
  final Map<int, String> leftTitles;
  final Map<int, String> rightTitles;

  final Map<int, List<FlSpot>> mainDataSpots;
  final Map<int, List<FlSpot>> otherDataSpots;

  final Map<int, Color> mainDataColors;
  final Map<int, Color> otherDataColors;

  final LineChartAppearanceData data;

  @protected
  LineChartGraph({
    int singularSize,
    LineChartType type,
    this.title,
    this.subTitle,
    this.lineWidth = 8,
    this.lineCount = 3,
    this.topTitles = const {},
    this.bottomTitles = const {},
    this.leftTitles = const {},
    this.rightTitles = const {},
    this.mainDataSpots = const {},
    this.otherDataSpots = const {},
    Map<int, Color> mainDataColors,
    Map<int, Color> otherDataColors,
  })  : mainDataColors = mainDataColors.isEmpty
            ? ThemeScheme.chartPalette.asMap()
            : mainDataColors,
        otherDataColors = otherDataColors.isEmpty
            ? ThemeScheme.chartPalette.asMap()
            : otherDataColors,
        data = LineChartAppearanceData(
          type: type,
          singularSize: singularSize,
        ),
        super(type: ChartType.LineChart);

  factory LineChartGraph.fromJson(Map<String, dynamic> json,
      {@required int singularSize, @required LineChartType type}) {
    return new LineChartGraph(
      singularSize: singularSize,
      type: type,
      title: json["title"],
      subTitle: json["subTitle"],
      lineCount: json["lineCount"] as int,
      topTitles: (json["topTitles"] as Map).castTo<int, String>(),
      bottomTitles: (json["bottomTitles"] as Map).castTo<int, String>(),
      leftTitles: (json["leftTitles"] as Map).castTo<int, String>(),
      rightTitles: (json["rightTitles"] as Map).castTo<int, String>(),
      mainDataSpots: (json["mainDataSpots"] as Map).castTo<int, List<FlSpot>>(
        getValue: (value) => LineSpots.fromJson(value).spots,
      ),
      otherDataSpots: (json["otherDataSpots"] as Map).castTo<int, List<FlSpot>>(
        getValue: (value) => LineSpots.fromJson(value).spots,
      ),
      mainDataColors: (json["mainDataColors"] as Map).castTo<int, Color>(
        getValue: (value) => HexColor.fromHex(value),
      ),
      otherDataColors: (json["otherDataColors"] as Map).castTo<int, Color>(
        getValue: (value) => HexColor.fromHex(value),
      ),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
                    padding: const EdgeInsets.all(4.0),
                    child: ChartData(
                      data: LineChart(
                        isShowingMainData
                            ? charts.mainDataGraph(
                                widget.data.mainMinX,
                                widget.data.mainMaxX,
                                widget.data.mainMaxY,
                                widget.data.mainMinY,
                                widget.mainDataSpots,
                                widget.mainDataColors,
                                widget.data.gridData,
                                widget.data.textStyle,
                                topTitles: widget.topTitles,
                                bottomTitles: widget.bottomTitles,
                                leftTitles: widget.leftTitles,
                                rightTitles: widget.rightTitles,
                                borderColor: Color(0xff000000),
                              )
                            : charts.otherDataGraph(
                                widget.data.otherMinX,
                                widget.data.otherMaxX,
                                widget.data.otherMaxY,
                                widget.data.otherMinY,
                                widget.otherDataSpots,
                                widget.otherDataColors,
                                widget.data.gridData,
                                topTitles: widget.topTitles,
                                bottomTitles: widget.bottomTitles,
                                leftTitles: widget.leftTitles,
                                rightTitles: widget.rightTitles,
                                borderColor: Color(0xff000000),
                              ),
                      ),
                      title: widget.title,
                      subTitle: widget.subTitle,
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
