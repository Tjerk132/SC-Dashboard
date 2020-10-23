import 'package:flutter/material.dart';

class ChartTitle extends StatefulWidget {
  final String title;
  final String subTitle;

  ChartTitle({
    Key key,
    this.title = '',
    this.subTitle = '',
  }) : super(key: key);

  @override
  _ChartTitleState createState() => _ChartTitleState();
}

class _ChartTitleState extends State<ChartTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.zero,
          child: Text(
            widget.subTitle,
            style: TextStyle(
              color: Color(0xff827daa),
              // fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.zero,
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              // fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
