import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/views/dashboard/components/tile.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';

/// the purpose of this class in to align 2x1 and [TitleTileGroup] tiles in the grid
/// correctly. this is achieved with the two ratio's [portraitTileHeightRatio]
/// and [landscapeTileHeightRatio] that give the ratio to which the
/// current tile will be scaled to.
class ConstrainedTile extends StatefulWidget {
  final Widget child;
  final double portraitTileHeightRatio;
  final double landscapeTileHeightRatio;

  ConstrainedTile({
    Key? key,
    required this.child,
    required this.portraitTileHeightRatio,
    required this.landscapeTileHeightRatio
  }) : super(key: key);

  @override
  State<ConstrainedTile> createState() => _ConstrainedTileState();
}

class _ConstrainedTileState extends State<ConstrainedTile> {
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
      child: Tile(child: widget.child),
    );
  }
}
