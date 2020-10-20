import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart_data/line_chart_data_samples.dart';
import 'package:flutter_test_project/models/charts/chart_data.dart';
import 'chart.dart';

class LineChartGraph extends Chart {
  LineChartGraph({this.lineWidth = 8, this.lineCount = 3});

  final double lineWidth;
  final int lineCount;

  @override
  State<LineChartGraph> createState() =>
      LineChartGraphState(this.lineWidth, this.lineCount);
}

class LineChartGraphState extends State<LineChartGraph> {
  // testing data
  final List<String> leftTitles = [
    '1m',
    '2m',
    '3m',
    '5m',
    '6m',
  ];
  final Map<int, String> bottomTitles = {
    2: 'SEPT',
    7: 'OCT',
    12: 'DEC',
  };
  final Map<int, List<FlSpot>> mainDataSpots = {
    0: [
      FlSpot(1, 1),
      FlSpot(3, 1.5),
      FlSpot(5, 1.4),
      FlSpot(7, 3.4),
      FlSpot(10, 2),
      FlSpot(12, 2.2),
      FlSpot(13, 1.8),
    ],
    1: [
      FlSpot(1, 1),
      FlSpot(3, 2.8),
      FlSpot(7, 1.2),
      FlSpot(10, 2.8),
      FlSpot(12, 2.6),
      FlSpot(13, 3.9),
    ],
    2: [
      FlSpot(1, 2.8),
      FlSpot(3, 1.9),
      FlSpot(6, 3),
      FlSpot(10, 1.3),
      FlSpot(13, 2.5),
    ]
  };

  // green, purple, blue
  final Map<int, Color> mainDataColors = {
    0: const Color(0xff4af699),
    1: const Color(0xffaa4cfc),
    2: const Color(0xff27b6fc),
  };
  final Map<int, List<FlSpot>> otherDataSpots = {
    0: [
      FlSpot(1, 1),
      FlSpot(3, 4),
      FlSpot(5, 1.8),
      FlSpot(7, 5),
      FlSpot(10, 2),
      FlSpot(12, 2.2),
      FlSpot(13, 1.8),
    ],
    1: [
      FlSpot(1, 1),
      FlSpot(3, 2.8),
      FlSpot(7, 1.2),
      FlSpot(10, 2.8),
      FlSpot(12, 2.6),
      FlSpot(13, 3.9),
    ],
    2: [
      FlSpot(1, 3.8),
      FlSpot(3, 1.9),
      FlSpot(6, 5),
      FlSpot(10, 3.3),
      FlSpot(13, 4.5),
    ]
  };
  final Map<int, Color> otherDataColors = {
    0: const Color(0x444af699),
    1: const Color(0x99aa4cfc),
    2: const Color(0x4427b6fc),
  };

  LineChartGraphState(double lineWidth, int lineCount)
      : samples = LineChartDataSamples(lineWidth, lineCount);

  final LineChartDataSamples samples;

  bool isShowingMainData = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AspectRatio(
        aspectRatio: 1.23,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            gradient: LinearGradient(
              colors: const [
                Color(0xff2c274c),
                Color(0xff46426c),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  alignment: Alignment.topLeft,
                  icon: Icon(
                    Icons.refresh,
                    color:
                        Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      isShowingMainData = !isShowingMainData;
                    });
                  },
                ),
              ),
              ChartData(
                data: isShowingMainData
                    ? samples.sampleData1(
                        leftTitles,
                        bottomTitles,
                        mainDataSpots,
                        mainDataColors,
                      )
                    : samples.sampleData2(
                        leftTitles,
                        bottomTitles,
                        otherDataSpots,
                        otherDataColors,
                      ),
                title: 'Line chart title',
                subTitle: 'Line Chart subtitle',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
