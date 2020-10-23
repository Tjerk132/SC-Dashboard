import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart_data.dart';
import 'package:flutter_test_project/models/charts/pie_chart/basic_pie_chart_data.dart';
import '../chart.dart';
import 'package:flutter_test_project/utility/utility.dart';

import 'indicator.dart';

class PieChartGraph extends Chart {
  final List<String> indicatorText;
  final List<Color> sectionColors;
  final List<double> values;
  final double pieRadius;
  final int pieCount;

  PieChartGraph({
    this.pieRadius = 60,
    this.pieCount = 3,
    this.values = const [],
    this.indicatorText = const [],
    this.sectionColors = const [],
  });

  factory PieChartGraph.fromJson(Map<String, dynamic> json) {
    return new PieChartGraph(
      indicatorText: (json["indicatorText"] as List<dynamic>).cast<String>(),
      sectionColors: [
        for (String colorString in (json["sectionColors"] as List<dynamic>).cast<String>())
          JsonColor(colorString)
      ],
      values: (json["values"] as List<dynamic>).cast<double>(),
      pieRadius: json["pieRadius"] as double,
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
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Indicator>.generate(
                widget.pieCount,
                (index) => Indicator(
                  color: widget.sectionColors[index],
                  text: widget.indicatorText[index],
                  shape: BoxShape.circle,
                  size: touchedIndex == index ? 18 : 16,
                  textColor: touchedIndex == index ? Colors.black : Colors.grey,
                ),
              ),
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
                      pieTouchData: PieTouchData(
                        touchCallback: (pieTouchResponse) =>
                            touchCallback(pieTouchResponse),
                      ),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 12,
                      centerSpaceRadius: 0,
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
