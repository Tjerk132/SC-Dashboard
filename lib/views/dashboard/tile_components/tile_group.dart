import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/tile_group_creator.dart';
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
/// and [object]. [object] is what will be displayed inside the TileGroup and has
/// to be of type [Widget].
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

  final ChartType type;

  final int singularSize;

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
  Widget getTile() {
    //todo remove index of assign properly
    final Chart chart = Chart.byType(widget.type, widget);

    if (widget is PlaceholderTileGroup) {
      return PlaceholderTile(size: widget.horizontal + widget.vertical);
    } else if (widget.alignVertically) {
      return VerticalTile(chart: chart);
    } else
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
              child: getTile(),
            ),
          ),
        ),
      ),
    );
  }
}
