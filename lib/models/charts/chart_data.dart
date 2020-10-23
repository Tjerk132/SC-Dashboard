import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart_title.dart';

class ChartData extends StatefulWidget {
  final ImplicitlyAnimatedWidget data;
  final bool showTitle;
  final String title;
  final String subTitle;

  ChartData({
    Key key,
    @required this.data,
    this.showTitle = true,
    this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  State<ChartData> createState() => _ChartDataState();
}

class _ChartDataState extends State<ChartData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        widget.showTitle
            ? ChartTitle(
                title: widget.title,
                subTitle: widget.subTitle,
              )
            : SizedBox(),
        const SizedBox(
          height: 2,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: widget.data,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
      ],
    );
  }
}
