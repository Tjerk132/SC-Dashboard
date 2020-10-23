import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/views/dashboard/tile.dart';

class VerticalTile extends StatefulWidget {
  const VerticalTile({this.chart});

  final Chart chart;

  @override
  State<VerticalTile> createState() => _VerticalTileState();
}

class _VerticalTileState extends State<VerticalTile> {
  //orig = 6.2
  // ratio to which 2x1 tile matches the height of a 1x1 tile
  // todo: now only works for even fits (necessary for uneven?)
  final double verticalTileHeightRatio = 6.2;

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    return Container(
      constraints: BoxConstraints(
        maxHeight: data.orientation == Orientation.landscape
            ? data.size.height / 4
            : data.size.height / verticalTileHeightRatio,
        maxWidth: data.size.width,
      ),
      child: Tile(chart: widget.chart),
    );
  }
}
