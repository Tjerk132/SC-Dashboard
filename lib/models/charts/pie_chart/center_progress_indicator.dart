import 'package:flutter/material.dart';

class CenterProgressIndicator extends StatefulWidget {
  final double value;
  final double fontSize;
  final Color color;

  CenterProgressIndicator({
    Key key,
    this.value,
    this.fontSize,
    this.color,
  }) : super(key: key);

  @override
  _CenterProgressIndicatorState createState() => _CenterProgressIndicatorState();
}

class _CenterProgressIndicatorState extends State<CenterProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 5,
      child: Text(
        '${widget.value}%',
        style: TextStyle(
          fontSize: widget.fontSize,
          color: widget.color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}