import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/indicator.dart';
import 'package:flutter_test_project/models/charts/pie_chart/pie.dart';
import 'chart.dart';

class PieChartGraph extends Chart {
  PieChartGraph({this.pieRadius = 60});

  final double pieRadius;

  @override
  State<PieChartGraph> createState() => PieChartGraphState();
}

class PieChartGraphState extends State<PieChartGraph> {
  int touchedIndex;

  /// the number of pies that will be created (testing purpose)
  int pieCount = 3;
  // testing data
  Map<int, String> indicatorText = {0: "One", 1: "Two", 2: "Three", 3: "Four"};
  Map<int, Color> sectionColor = {
    0: Color(0xff0293ee),
    1: Color(0xfff8b250),
    2: Color(0xff845bef),
    3: Color(0xff13d38e)
  };

  void touchCallback(PieTouchResponse pieTouchResponse) {
    setState(() {
      if (pieTouchResponse.touchInput is FlLongPressEnd ||
          pieTouchResponse.touchInput is FlPanEnd) {
        touchedIndex = -1;
      }
      else {
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
                pieCount,
                (index) => Indicator(
                  color: sectionColor[index],
                  text: indicatorText[index],
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
                child: PieChart(
                  PieChartData(
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
                    sections: List<Pie>.generate(
                      pieCount,
                      (index) => Pie(
                        color: sectionColor[index],
                        isTouched: index == touchedIndex,
                        value: 100 / pieCount,
                        pieRadius: widget.pieRadius,
                      ),
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
