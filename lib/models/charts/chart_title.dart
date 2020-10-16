import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartTitle extends StatefulWidget {
  ChartTitle({@required this.data, this.title = 'Title', this.subTitle = 'subTitle'});

  final AxisChartData data;
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.zero,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.subTitle,
              style: TextStyle(
                color: Color(0xff827daa),
                // fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Padding(
          //todo only set padding to 15 if small group else to zero
          padding: EdgeInsets.only(left: 15.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${widget.title}',
              style: TextStyle(
                  color: Colors.white,
                  // fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(2.0),
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
          height: 2,
        ),
      ],
    );
  }
}
