import 'package:flutter/material.dart';

class ChartTitle extends StatefulWidget {
  final String title;
  final String subTitle;

  ChartTitle({
    Key key,
    this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  _ChartTitleState createState() => _ChartTitleState();
}

class _ChartTitleState extends State<ChartTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.black,
              // fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 2.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.subTitle,
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontWeight: FontWeight.bold,
                // fontSize: 12,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }
}
