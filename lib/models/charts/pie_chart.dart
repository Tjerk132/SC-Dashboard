import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class PieChartGraph extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartGraphState();
}

class PieChartGraphState extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Indicator(
                  color: const Color(0xff0293ee),
                  text: 'One',
                  shape: BoxShape.circle,
                  size: touchedIndex == 0 ? 18 : 16,
                  textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: const Color(0xfff8b250),
                  text: 'Two',
                  shape: BoxShape.circle,
                  size: touchedIndex == 1 ? 18 : 16,
                  textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: const Color(0xff845bef),
                  text: 'Three',
                  shape: BoxShape.circle,
                  size: touchedIndex == 2 ? 18 : 16,
                  textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: const Color(0xff13d38e),
                  text: 'Four',
                  shape: BoxShape.circle,
                  size: touchedIndex == 3 ? 18 : 16,
                  textColor: touchedIndex == 3 ? Colors.black : Colors.grey,
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(
                          touchCallback: (pieTouchResponse) {
                            setState(() {
                              if (pieTouchResponse
                                  .touchInput is FlLongPressEnd ||
                                  pieTouchResponse.touchInput is FlPanEnd) {
                                touchedIndex = -1;
                              } else {
                                touchedIndex =
                                    pieTouchResponse.touchedSectionIndex;
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
    return List.generate(
        4,
            (i) {
          final isTouched = i == touchedIndex;
          final double opacity = isTouched ? 1 : 0.6;
          switch (i) {
            case 0:
              return PieChartSectionData(
                color: const Color(0xff0293ee).withOpacity(opacity),
                value: 20,
                title: '',
                radius: isTouched ? 120 : 60,
                titleStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff044d7c)),
                titlePositionPercentageOffset: 0.55,
              );
            case 1:
              return PieChartSectionData(
                color: const Color(0xfff8b250).withOpacity(opacity),
                value: 30,
                title: '',
                radius: isTouched ? 120 : 60,
                titleStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff90672d)),
                titlePositionPercentageOffset: 0.55,
              );
            case 2:
              return PieChartSectionData(
                color: const Color(0xff845bef).withOpacity(opacity),
                value: 38,
                title: '',
                radius: isTouched ? 120 : 60,
                titleStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff4c3788)),
                titlePositionPercentageOffset: 0.6,
              );
            case 3:
              return PieChartSectionData(
                color: const Color(0xff13d38e).withOpacity(opacity),
                value: 12,
                title: '',
                radius: isTouched ? 120 : 60,
                titleStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff0c7f55)),
                titlePositionPercentageOffset: 0.55,
              );
            default:
              return null;
          }
        }
    );
  }
}