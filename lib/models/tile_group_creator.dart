import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';

import 'charts/chart.dart';

class TileGroupCreator {


  TileGroup bySize(int size, List<Chart> charts) {
    switch (size) {
      case 1:
        return SmallTileGroup(charts);
      case 2:
        return MediumTileGroup(charts);
      case 3:
        return null;
      case 4:
        return LargeTileGroup(charts);
      default:
        return SmallTileGroup(charts);
    }
  }
}