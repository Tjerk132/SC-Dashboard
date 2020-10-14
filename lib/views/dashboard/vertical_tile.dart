import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/views/dashboard/tile.dart';

class VerticalTile extends StatefulWidget {
  const VerticalTile({this.chart});

  final Chart chart;

  @override
  State<StatefulWidget> createState() => _VerticalTileState();
}

class _VerticalTileState extends State<VerticalTile> {
  //orig = 6.2
  // ratio to which 2x1 tile matches the height of a 1x1 tile todo: now only works for fit 2
  final double verticalTileHeightRatio = 6.5;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.amber,
      constraints: BoxConstraints(
        maxHeight: size.height / verticalTileHeightRatio,
        minWidth: size.width),
      child: Tile(chart: widget.chart),
    );
  }
}
