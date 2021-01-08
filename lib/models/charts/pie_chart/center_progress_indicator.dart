import 'package:flutter/material.dart';

class CenterProgressIndicator extends StatefulWidget {
  final double value;
  final TextStyle style;

  CenterProgressIndicator({
    Key key,
    this.value,
    this.style,
  }) : super(key: key);

  @override
  _CenterProgressIndicatorState createState() =>
      _CenterProgressIndicatorState();
}

class _CenterProgressIndicatorState extends State<CenterProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 5.3,
      child: Container(
        color: Colors.white.withOpacity(0.8),
        child: Text(
          '${widget.value}%',
          style: widget.style,
        ),
      ),
    );
  }
}
