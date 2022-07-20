import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/pie_chart_type.dart';

class CenterProgressIndicator extends StatefulWidget {
  final String? title;
  final PieChartType type;
  final double value;
  final TextStyle style;

  CenterProgressIndicator({
    Key? key,
    this.title,
    required this.type,
    required this.value,
    required this.style,
  }) : super(key: key);

  @override
  _CenterProgressIndicatorState createState() =>
      _CenterProgressIndicatorState();
}

class _CenterProgressIndicatorState extends State<CenterProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // widthFactor: 5.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.type == PieChartType.gauge
              ? SizedBox(
                  width: 100,
                  child: Text(
                    widget.title!,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : SizedBox(),
          Text(
            '${widget.value}%',
            style: widget.style,
          ),
        ],
      ),
    );
  }
}
