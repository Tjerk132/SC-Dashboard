import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/models/session/session_title.dart';
import 'package:flutter_test_project/shimmering/skeleton.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../components/tile.dart';
import '../components/constrained_tile.dart';

class TileGroup extends StatefulWidget {
  /// the children that will be displayed inside the group
  final List<Widget> children;

  /// the type of the group
  final TileGroupType type;

  /// represents the size of one element in this group
  // final int singularSize;

  /// represents the size in total that this groups takes in
  final int occupationSize;

  /// represents the number of rows that can fit within the current tile group
  final int horizontal;

  /// represents the number of columns that can fit within the current tile group
  final int vertical;

  TileGroup.small(
    this.children,
  )   : type = TileGroupType.small,
        occupationSize = 4,
        horizontal = 2,
        vertical = 2;

  TileGroup.medium(
    this.children,
  )   : type = TileGroupType.medium,
        occupationSize = 2,
        horizontal = 2,
        vertical = 1;

  TileGroup.large(
    this.children,
  )   : type = TileGroupType.large,
        occupationSize = 4,
        horizontal = 1,
        vertical = 1;


  factory TileGroup.byFactor(
    int factor,
    List<Widget> children,
  ) {
    TileGroupType type = TileGroupType.values.firstWhere((type) => type.factor == factor);
    return type.instance(children);
  }

  factory TileGroup.asShimmer() => TileGroup.large(List.filled(1, Skeleton()));

  bool get alignVertically => children.length.isOdd;

  @override
  _TileGroupState createState() => _TileGroupState();
}

class _TileGroupState extends State<TileGroup> {
  //todo: fix RangeError on reload bc of index
  int index = 0;

  Widget getTile(DeviceScreenType deviceScreenType) {
    Widget child = widget.children[index];

    index++;
    if (widget.type == TileGroupType.medium /* widget is MediumTileGroup*/) {
      return ConstrainedTile(
        child: child,
        landscapeTileHeightRatio: 2.5,
        portraitTileHeightRatio:
            5.0 * (deviceScreenType == DeviceScreenType.mobile ? 0.8 : 1.0),
      );
    } else if (child is SessionTitle /*widget is TitleTileGroup*/) {
      return ConstrainedTile(
        child: child,
        landscapeTileHeightRatio: 10.0,
        portraitTileHeightRatio:
            20.0 * (deviceScreenType == DeviceScreenType.mobile ? 0.8 : 1.0),
      );
    } else
      return Tile(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        return Column(
          children: List.generate(
            widget.vertical,
            (y) => Row(
              children: List.generate(
                widget.alignVertically ? 1 : widget.horizontal,
                (x) => Expanded(
                  child: getTile(DeviceScreenType.mobile),
                ),
              ),
            ),
          ),
        );
      },
      tablet: (context) {
        return Column(
          children: List.generate(
            widget.vertical,
            (y) => Row(
              children: List.generate(
                widget.alignVertically ? 1 : widget.horizontal,
                (x) => Expanded(
                  child: getTile(DeviceScreenType.tablet),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
