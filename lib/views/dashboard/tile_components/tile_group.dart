import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/tile_group_creator.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';
import 'package:flutter_test_project/views/dashboard/vertical_tile.dart';
import '../place_holder_tile.dart';
import '../tile.dart';

abstract class TileGroup extends StatefulWidget {
  TileGroup.fromSize(this.chart, this.horizontal, this.vertical);

  factory TileGroup.sizeFactory(Chart chart, {@required int size}) {
    return TileGroupCreator(size).group(chart);
  }

  TileGroup.fromDimensions(this.chart,
      {@required this.horizontal, @required this.vertical});

  factory TileGroup.dimensionFactory(Chart chart,
      {@required int horizontal, @required int vertical}) {
    return TileGroupCreator(horizontal * vertical).group(chart);
  }

  final Chart chart;

  //represents the number of rows that can fit within the current tile group
  final int horizontal;
  //represents the number of columns that can fit within the current tile group
  final int vertical;

  int get occupiedSpace => horizontal * vertical;

  bool get alignVertically => horizontal != vertical;

  @override
  _TileGroupState createState() => _TileGroupState();

}

class _TileGroupState extends State<TileGroup> {
  Widget getTile() {
    if (widget is PlaceholderTileGroup) {
      return PlaceholderTile(size: widget.horizontal+widget.vertical);
    }
    else if (widget.alignVertically) {
      return VerticalTile(chart: widget.chart);
    }
    else
      return Tile(chart: widget.chart);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.vertical,
        (index) => Row(
          // mainAxisSize: MainAxisSize.max,
          children: List.generate(
            widget.alignVertically ? 1 : widget.horizontal,
            (index) => Expanded(
              child: getTile(),
            ),
          ),
        ),
      ),
    );
  }
}
