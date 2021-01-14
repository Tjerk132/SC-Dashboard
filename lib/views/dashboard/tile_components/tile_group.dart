import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/tile_group_creator.dart';
import 'package:flutter_test_project/shimmering/skeleton.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';

import '../tile.dart';
import '../constrained_tile.dart';

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
/// and requires the parameters [horizontal], [vertical]
/// and [children]. [children] is what will be displayed
/// inside the TileGroup and has to be of type [Widget].
abstract class TileGroup extends StatefulWidget {
  TileGroup.fromDimensions(
    this.children, {
    @required this.singularSize,
    @required this.occupationSize,
    @required this.horizontal,
    @required this.vertical,
  });

  factory TileGroup.singularSizeFactory(
      List<Widget> children, int singularSize) {
    return TileGroupCreator().bySize(singularSize, children);
  }

  factory TileGroup.asShimmer(int singularSize) {
    return TileGroupCreator().bySize(singularSize, List.filled(1, Skeleton()));
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

  @override
  _TileGroupState createState() => _TileGroupState();
}

class _TileGroupState extends State<TileGroup> {
  int index = 0;

  Widget getTile() {
    if (index > (widget.children.length - 1)) {
      return SizedBox();
    } else {
      Widget child = widget.children[index];
      index++;
      //todo scale for phone (with DeviceType)
      if (widget is MediumTileGroup) {
        return ConstrainedTile(
          child: child,
          landscapeTileHeightRatio: 1.88,
          portraitTileHeightRatio: 4.93,
        );
      } else if (widget is TitleTileGroup) {
        return ConstrainedTile(
          child: child,
          landscapeTileHeightRatio: 20.0,
          portraitTileHeightRatio: 35.0,
        );
      } else
        return Tile(child: child);
    }
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
