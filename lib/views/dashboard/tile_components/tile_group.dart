import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/tile_group_creator.dart';

import '../text_tile.dart';
import '../tile.dart';
import '../vertical_tile.dart';

/// TileGroup requires to be extended by a subclass,
/// all extending classes of the [TileGroup] class are present
/// in the file [tile_groups.dart]
///
/// Example:
/// ```dart
/// class SmallTileGroup extends TileGroup {
///   SmallTileGroup(Widget child)
///       : super.fromDimensions(child, horizontal: 2, vertical: 2);
/// }
/// ```
/// and require the parameters [horizontal], [vertical]
/// and [children]. [children] is what will be displayed
/// inside the TileGroup and has to be of type [Widget].
abstract class TileGroup extends StatefulWidget {
  TileGroup.fromSize(
    this.children, {
    @required this.singularSize,
    @required this.occupationSize,
    @required int size,
  })  : horizontal = 4,
        vertical = size - (size ~/ 2);

  // factory TileGroup.sizeFactory(List<Chart> charts, {@required int size}) {
  //   return TileGroupCreator().bySize(size, charts);
  // }

  TileGroup.fromDimensions(
    this.children, {
    @required this.singularSize,
    @required this.occupationSize,
    @required this.horizontal,
    @required this.vertical,
  });

  // factory TileGroup.dimensionFactory(List<Chart> charts,
  //     {@required int horizontal, @required int vertical}) {
  //   return TileGroupCreator().bySize(horizontal * vertical, charts);
  // }

  factory TileGroup.singularSizeFactory(List<Widget> children, int singularSize) {
    return TileGroupCreator().bySize(singularSize, children);
  }

  /// the children that will be displayed inside the group
  final List<Widget> children;

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

  DateTime get date {
    return (children[0] as Chart).date;
    // if (children.length == 1) {
    //   return children[0].date;
    // } else {
    //   DateTime first, last = children[0].date;
    //   for (DateTime date in children.map((chart) => chart.date)) {
    //     if (date.isBefore(first)) {
    //       first = date;
    //     }
    //     if (date.isAfter(last)) {
    //       last = date;
    //     }
    //   }
    //   return first.add(first.difference(last) ~/ 2);
    // }
  }

  @override
  _TileGroupState createState() => _TileGroupState();
}

class _TileGroupState extends State<TileGroup> {
  int chartIndex = 0;

  Widget getTile() {
    Widget child = widget.children.elementAt(chartIndex);
    chartIndex++;
    if (widget.alignVertically) {
      return VerticalTile(child: child);
    }
    else
      return Tile(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.vertical,
        (index) => Row(
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
