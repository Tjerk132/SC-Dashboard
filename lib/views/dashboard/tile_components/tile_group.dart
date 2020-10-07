import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/tile_group_creator.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';
import 'package:flutter_test_project/views/dashboard/vertical_tile.dart';
import '../place_holder_tile.dart';
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

  Widget getTile() {
    if(widget.alignVertically) {
      return VerticalTile(chart: widget.chart);
    }
    else if(widget.isPlaceHolder) {
      return PlaceholderTile(size: widget.occupiedSpaces);
    }
    else return Tile(chart: widget.chart);
  }
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
              child: getTile(),
              // child: Column(
              //   children: <Widget>[
              //
              //     widget.alignVertically ?
              //      VerticalTile(chart: widget.chart),
              //     :
              //     ;
              //     if(widget.isPlaceHolder || widget.alignVertically)
              //     ...[
              //       VerticalTile(chart: widget.chart),
              //       // TilePlaceholder(chart: widget.chart),
              //     ]
              //     else Tile(chart: widget.chart),
              //
              //   ],
              // )
            )
          ),
        ),
      ),
    );
  }
}
