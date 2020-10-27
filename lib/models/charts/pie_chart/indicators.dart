import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/pie_chart_appearance.dart';

import 'indicator.dart';

class Indicators extends StatefulWidget {
  final int pieCount;
  final double pieRadius;
  final List<double> values;
  final List<String> indicatorText;
  final List<Color> sectionColors;
  final int touchedIndex;
  final PieChartType type;
  final BoxShape shape;

  Indicators({
    Key key,
    @required this.pieCount,
    @required this.pieRadius,
    @required this.values,
    @required this.indicatorText,
    @required this.sectionColors,
    @required this.touchedIndex,
    this.type = PieChartType.rectangular,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  @override
  _IndicatorsState createState() => _IndicatorsState();
}

class _IndicatorsState extends State<Indicators> {

  List<Indicator> generateIndicators() {
    return List<Indicator>.generate(
      widget.pieCount,
      (index) => Indicator(
        color: widget.sectionColors[index],
        text: widget.indicatorText[index],
        shape: widget.shape,
        size: widget.touchedIndex == index ? 18 : 16,
        textColor: widget.touchedIndex == index ? Colors.black : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case PieChartType.rectangular:
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: generateIndicators(),
        );
      case PieChartType.donut:
      case PieChartType.circular:
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: generateIndicators(),
        );
      default:
        return SizedBox();
    }
  }
}
