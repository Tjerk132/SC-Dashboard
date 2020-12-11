import 'package:flutter/material.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

class SmallTileGroup extends TileGroup {
  SmallTileGroup(List<Widget> children)
      : super.fromDimensions(children,
            singularSize: 1, occupationSize: 4, horizontal: 2, vertical: 2);
}

class MediumTileGroup extends TileGroup {
  MediumTileGroup(List<Widget> children)
      : super.fromDimensions(children,
            singularSize: 2, occupationSize: 2, horizontal: 2, vertical: 1);
}

class LargeTileGroup extends TileGroup {
  LargeTileGroup(List<Widget> children)
      : super.fromDimensions(children,
            singularSize: 4, occupationSize: 4, horizontal: 1, vertical: 1);
}

class TitleTileGroup extends TileGroup {
  TitleTileGroup(Widget child)
      : super.fromDimensions([child],
            singularSize: 1, occupationSize: 1, horizontal: 4, vertical: 1);
}
