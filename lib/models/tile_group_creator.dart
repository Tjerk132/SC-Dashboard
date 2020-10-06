import 'package:flutter/material.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';

import 'charts/chart.dart';

class TileGroupCreator {

  int size;

  TileGroupCreator(this.size);

  TileGroup group(Chart chart) {
    switch (size) {
      case 1:
        return SmallTileGroup(chart);
      case 2:
        return MediumTileGroup(chart);
      case 3:
        //todo implement logger
        print('Warn [No tile could be created with the given size $size]');
      //todo 3sized tile (tbi) & change alignVertical for this case
        return null;
      case 4:
        return LargeTileGroup(chart);
      default:
        return SmallTileGroup(chart);
    }
  }
}