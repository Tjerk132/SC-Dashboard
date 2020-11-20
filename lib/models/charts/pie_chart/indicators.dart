import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/pie_chart_type.dart';

import 'indicator.dart';

class Indicators extends StatefulWidget {
  final int pieCount;
  final List<String> indicatorText;
  final List<Color> sectionColors;
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
        size: widget.indicatorSize,
        fontSize: widget.fontSize,
        textColor: Colors.black,
      ),
    );
  }

  Padding title({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: widget.fontSize,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case PieChartType.divided:
        return Column(
          children: [
            title(bottom: 15.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: generateIndicators(),
            ),
          ],
        );
      case PieChartType.donut:
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title(), ...generateIndicators()],
        );
      case PieChartType.circle:
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title(), ...generateIndicators()],
        );
      case PieChartType.progression:
        return title(
          left: 8.0,
          top: 4.0,
        );
      default:
        return SizedBox();
    }
  }
}
