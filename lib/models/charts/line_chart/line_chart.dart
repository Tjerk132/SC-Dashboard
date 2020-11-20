import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/enums/line_chart_type.dart';
import 'package:flutter_test_project/models/charts/base_chart_data/basic_line_chart_data.dart';
import 'package:flutter_test_project/models/charts/chart_appearance/line_chart_appearance_data.dart';
import 'package:flutter_test_project/models/charts/chart_data.dart';
import 'package:flutter_test_project/models/charts/line_chart/line_spots.dart';
import 'package:flutter_test_project/models/theme_scheme.dart';
import '../chart.dart';
import 'package:flutter_test_project/utility/utility.dart';

class LineChartGraph extends Chart {
  final double lineWidth;
  final int lineCount;

  final Map<int, String> topTitles;
  final Map<int, String> bottomTitles;
  final Map<int, String> leftTitles;
  final Map<int, String> rightTitles;

  final Map<int, List<FlSpot>> spots;
  final Map<int, Color> colors;

  final LineChartAppearanceData data;

  @protected
  LineChartGraph({
    int singularSize,
    LineChartType type,
    String title,
    String subTitle,
    DateTime date,
    this.lineWidth = 8,
    this.lineCount = 3,
    this.topTitles = const {},
    this.bottomTitles = const {},
    this.leftTitles = const {},
    this.rightTitles = const {},
    this.spots = const {},
    Map<int, Color> colors,
  })  : colors = colors.isEmpty ? ThemeScheme.chartPalette.asMap() : colors,
        data = LineChartAppearanceData(
          type: type,
          singularSize: singularSize,
        ),
        super(
          type: ChartType.LineChart,
          title: title,
          subTitle: subTitle,
          date: date,
        );

  factory LineChartGraph.fromJson(
    Map<String, dynamic> json, {
    @required int singularSize,
    @required LineChartType type,
  }) {
    return new LineChartGraph(
      singularSize: singularSize,
      date: DateTime.parse(json["date"]),
      type: type,
      title: json["title"],
      subTitle: json["subTitle"],
      lineCount: json["lineCount"] as int,
      topTitles: (json["topTitles"] as Map).castTo<int, String>(),
      bottomTitles: (json["bottomTitles"] as Map).castTo<int, String>(),
      leftTitles: (json["leftTitles"] as Map).castTo<int, String>(),
      rightTitles: (json["rightTitles"] as Map).castTo<int, String>(),
      spots: (json["spots"] as Map).castTo<int, List<FlSpot>>(
        getValue: (value) => LineSpots.fromJson(value).spots,
      ),
      colors: (json["colors"] as Map).castTo<int, Color>(
        getValue: (value) => HexColor.fromHex(value),
      ),
    );
  }

  @override
  State<LineChartGraph> createState() => LineChartGraphState();
}

class LineChartGraphState extends State<LineChartGraph> {
  // bool isShowingMainData = true;

  @override
  void initState() {
    super.initState();
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
                        BasicLineChartData(
                          lineTouchData: LineTouchData(
                            enabled: false,
                          ),
                          gridData: FlGridData(
                            show: false,
                          ),
                          reservedSize: 22,
                          margin: 8,
                          topTitles: widget.topTitles,
                          bottomTitles: widget.bottomTitles,
                          leftTitles: widget.leftTitles,
                          rightTitles: widget.rightTitles,
                          minX: widget.data.minX,
                          maxX: widget.data.maxX,
                          maxY: widget.data.maxY,
                          minY: widget.data.minY,
                          lineCount: widget.lineCount,
                          spots: widget.spots,
                          colors: widget.colors,
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
                          titleTextStyle: widget.data.textStyle,
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
