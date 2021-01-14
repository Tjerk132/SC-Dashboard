import 'package:flutter/material.dart';

import 'chart_title.dart';

class ChartData extends StatefulWidget {
  final ImplicitlyAnimatedWidget data;
  final bool showTitle;
  final String title;
  final String subTitle;

  ChartData(
    this.data, {
    Key key,
    this.showTitle = true,
    this.title = '',
    this.subTitle = '',
  }) : super(key: key) {
    assert(data != null);
  }

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
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: widget.data,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        widget.showTitle
            ? ChartTitle(
                title: widget.title,
                subTitle: widget.subTitle,
              )
            : SizedBox(),
      ],
    );
  }
}
