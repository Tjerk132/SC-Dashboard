import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/pie_chart_type.dart';

import 'indicator.dart';

class Indicators extends StatefulWidget {
  final int pieCount;
  final List<String> indicatorText;
  final List<Color> sectionColors;
  final int touchedIndex;
  final PieChartType type;
  final double indicatorSize;
  final double fontSize;
  final BoxShape shape;
  final String title;

  Indicators({
    Key key,
    @required this.pieCount,
    @required this.indicatorText,
    @required this.sectionColors,
    @required this.touchedIndex,
    @required this.type,
    this.indicatorSize,
    this.fontSize,
    this.shape = BoxShape.rectangle,
    this.title = '',
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
        size: widget.touchedIndex == index
            ? widget.indicatorSize + 2
            : widget.indicatorSize,
        fontSize: widget.fontSize,
        textColor: widget.touchedIndex == index ? Colors.black : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case PieChartType.divided:
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: generateIndicators(),
        );
      case PieChartType.donut:
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: generateIndicators(),
        );
      case PieChartType.circle:
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: generateIndicators(),
        );
      case PieChartType.progression:
        return Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: widget.fontSize,
              ),
            ),
        );
      default:
        return SizedBox();
    }
  }
}
