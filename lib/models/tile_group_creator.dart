import 'package:flutter/cupertino.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';

class TileGroupCreator {


  TileGroup bySize(int size, List<Widget> children) {
    switch (size) {
      case 1:
        return SmallTileGroup(children);
      case 2:
        return MediumTileGroup(children);
      case 4:
        return LargeTileGroup(children);
      default:
        throw StateError('Can\'t create a tileGroup for size $size');
    }
  }
}