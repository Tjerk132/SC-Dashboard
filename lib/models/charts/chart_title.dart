import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartTitle extends StatefulWidget {
  ChartTitle({@required this.data, @required this.index, this.title = 'Title', this.subTitle = 'subTitle'});

  final AxisChartData data;
  final int index;
  final String title;
  final String subTitle;

  @override
  State<StatefulWidget> createState() => _ChartTitleState();
}

class _ChartTitleState extends State<ChartTitle> {
  final Duration animDuration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(
          // height: 37,
          height: 12,
        ),
        Text(
          widget.subTitle,
          style: TextStyle(
            color: Color(0xff827daa),
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          '${widget.title} i=${widget.index}',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          // height: 37,
          height: 12,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 6.0),
            child: widget.data is LineChartData ?
              LineChart(
                widget.data,
                swapAnimationDuration: animDuration,
              )
              :
              BarChart(
                widget.data,
                swapAnimationDuration: animDuration
              ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
