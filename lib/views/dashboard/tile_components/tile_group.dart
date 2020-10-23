import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/tile_group_creator.dart';
import 'package:flutter_test_project/shimmering/tile_shimmer.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';
import 'package:flutter_test_project/views/dashboard/vertical_tile.dart';
import '../place_holder_tile.dart';
import '../tile.dart';

/// TileGroup requires to be extended by a subclass,
/// all extending classes of the [TileGroup] class are present
/// in the file [tile_groups.dart]
///
/// Example:
/// ```dart
/// class SmallTileGroup extends TileGroup {
///   SmallTileGroup(Widget object)
///       : super.fromDimensions(object, horizontal: 2, vertical: 2);
/// }
/// ```
/// and require the parameters [horizontal], [vertical]
/// and [type]. [type] is what will be the type of graph
/// displayed inside the TileGroup and has to be of type [Widget].
abstract class TileGroup extends StatefulWidget {
  TileGroup.fromSize(this.type,
      {@required this.singularSize,
      @required this.occupationSize,
      @required int size})
      : horizontal = size ~/ 2,
        vertical = size - (size ~/ 2);

  factory TileGroup.sizeFactory(ChartType type, {@required int size}) {
    return TileGroupCreator(size).group(type);
  }

  TileGroup.fromDimensions(this.type,
      {@required this.singularSize,
      @required this.occupationSize,
      @required this.horizontal,
      @required this.vertical});

  factory TileGroup.dimensionFactory(ChartType type,
      {@required int horizontal, @required int vertical}) {
    return TileGroupCreator(horizontal * vertical).group(type);
  }

  //todo general: now 1 component is duplicated to fill up the tile group's space (keep a list of this group's tiles)

  /// the type of chart the group will get
  final ChartType type;

  /// represents the size of one element in this group
  final int singularSize;

  /// represents the size in total that this groups takes in
  final int occupationSize;

  /// represents the number of rows that can fit within the current tile group
  final int horizontal;

  /// represents the number of columns that can fit within the current tile group
  final int vertical;

  int get tileCount => horizontal * vertical;

  bool get alignVertically => horizontal != vertical;

  @override
  _TileGroupState createState() => _TileGroupState();
}

class _TileGroupState extends State<TileGroup> {
  Widget getTile(Chart chart) {
    if (widget is PlaceholderTileGroup) {
      return PlaceholderTile(size: widget.occupationSize);
    }
    else if (widget.alignVertically) {
      return VerticalTile(chart: chart);
    }
    else
      return Tile(chart: chart);
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
              child: FutureBuilder<Chart>(
                future: Chart.byGroup(context, widget),
                builder: (BuildContext context, AsyncSnapshot<Chart> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('No future implemented');
                    case ConnectionState.waiting:
                      return TileShimmer(
                        height: 600,
                        imageShimmerRatio: 0.45,
                        titleShimmer: true,
                        textShimmers: 2,
                      );
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else
                        return getTile(snapshot.data);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
