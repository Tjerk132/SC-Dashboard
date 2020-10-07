import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';

class VerticalTile extends StatefulWidget {
  const VerticalTile({this.chart});

  final Chart chart;

  @override
  State<StatefulWidget> createState() => _VerticalTileState();
}

class _VerticalTileState extends State<VerticalTile> {
  // ratio to which 2x1 tile matches the height of a 1x1 tile todo: now only works for fit 2
  final double verticalTileHeightRatio = 6.2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
          maxHeight: size.height / verticalTileHeightRatio,
          minWidth: size.width),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        clipBehavior: Clip.antiAlias,
//      elevation: 4,
        child: AspectRatio(aspectRatio: 1.0, child: widget.chart),
      ),
    );
  }
}
