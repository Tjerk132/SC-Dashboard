import 'package:flutter/material.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

class SmallTileGroup extends TileGroup {
  SmallTileGroup(NetworkImage image)
      : super.fromDimensions(image, horizontal: 1, vertical: 1);
}

class MediumTileGroup extends TileGroup {
  MediumTileGroup(NetworkImage image)
      : super.fromDimensions(image, horizontal: 2, vertical: 1);
}

class LargeTileGroup extends TileGroup {
  LargeTileGroup(NetworkImage image)
      : super.fromDimensions(image, horizontal: 2, vertical: 2);
}
