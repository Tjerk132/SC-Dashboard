import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'chart.dart';
import 'indicator.dart';

class PieChartGraph extends Chart {
  PieChartGraph(int index) : super(index);

  @override
  State<PieChartGraph> createState() => PieChartGraphState();
}

class PieChartGraphState extends State<PieChartGraph> {
  int touchedIndex;

  int pieCount = 3;

  Map<int, String> indicatorText = {
    0: "One",
    1: "Two",
    2: "Three",
    3: "Four"
  };

  Map<int, Color> sectionColor = {
    0: Color(0xff0293ee),
    1: Color(0xfff8b250),
    2: Color(0xff845bef),
    3: Color(0xff13d38e)
  };

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            //todo remove after testing
            Text('index ${widget.index}',style: TextStyle(fontSize: 12)),
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Widget>.generate(pieCount, (index) =>
                Indicator(
                  color: sectionColor[index],
                  text: '${indicatorText[index]}',
                  shape: BoxShape.circle,
                  size: touchedIndex == index ? 18 : 16,
                  textColor: touchedIndex == index ? Colors.black : Colors.grey,
                ),
              )
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 12,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List<PieChartSectionData>.generate(pieCount, (i) {
      final isTouched = i == touchedIndex;
      final double opacity = isTouched ? 1 : 0.6;
      return PieChartSectionData(
        color: sectionColor[i].withOpacity(opacity),
        value: 100 / pieCount,
        title: '',
        radius: isTouched ? 120 : 60,
        titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: sectionColor[i]),
        titlePositionPercentageOffset: 0.55,
      );
    });
  }
}
