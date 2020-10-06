import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/tile_group_creator.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';
import 'package:flutter_test_project/views/dashboard/tile_placeholder.dart';
import '../tile.dart';

abstract class TileGroup extends StatefulWidget {

  TileGroup.fromSize(this.chart, this.horizontal, this.vertical);

  factory TileGroup.sizeFactory(Chart chart, {int size}) {
    return TileGroupCreator(size).group(chart);
  }

  TileGroup.fromDimensions(this.chart, {this.horizontal, this.vertical});
      // : creator = TileGroupCreator(horizontal * vertical);

  factory TileGroup.dimensionFactory(Chart chart,
      {int horizontal, int vertical}) {
    return TileGroupCreator(horizontal * vertical).group(chart);
  }

  final Chart chart;

  final int horizontal;
  final int vertical;

  int get occupiedSpaces => horizontal * vertical;

  bool get alignVertically => horizontal != vertical;

  bool get isPlaceHolder => this is PlaceholderTileGroup;

  @override
  _TileGroupState createState() => _TileGroupState();
}

class _TileGroupState extends State<TileGroup> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        widget.vertical,
        (index) => Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            widget.alignVertically ? 1 : widget.horizontal,
            (index) => Expanded(
              flex: 1,
              child: widget.isPlaceHolder
                  ? TilePlaceholder()
                  : Tile(index: index, chart: widget.chart),
            ),
          ),
        ),
      ),
    );
  }
}
