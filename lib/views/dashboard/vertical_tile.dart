import 'package:flutter/material.dart';
import 'package:flutter_test_project/device_type.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/views/dashboard/tile.dart';

/// the purpose of this class in to align 2x1 tiles in the grid
/// correctly. this is achieved with the two ratio's [portraitTileHeightRatio]
/// and [landscapeTileHeightRatio] that give the ratio to which
/// a 2x1 tile matches the height of a 1x1 tile.
class VerticalTile extends StatefulWidget {

  final Chart chart;
  final double portraitTileHeightRatio = DeviceType().isPhone ? 3.0 : 6.16;
  final double landscapeTileHeightRatio = DeviceType().isPhone ? 1.5 : 2.35;

  VerticalTile({
    Key key,
    this.chart,
  }) : super(key: key);

  @override
  State<VerticalTile> createState() => _VerticalTileState();
}

class _VerticalTileState extends State<VerticalTile> {
  // todo: now only works for even fits (necessary for uneven?)
  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    return Container(
      constraints: BoxConstraints(
        maxHeight: data.orientation == Orientation.landscape
            ? data.size.height / widget.landscapeTileHeightRatio
            : data.size.height / widget.portraitTileHeightRatio,
        maxWidth: data.size.width,
      ),
      child: Tile(chart: widget.chart),
    );
  }
}
