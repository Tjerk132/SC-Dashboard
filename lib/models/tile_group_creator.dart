import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';

import 'charts/chart.dart';

class TileGroupCreator {


  TileGroup bySize(int size, Chart chart) {
    switch (size) {
      case 1:
        return SmallTileGroup(chart);
      case 2:
        return MediumTileGroup(chart);
      case 3:
        return PlaceholderTileGroup(size);
      case 4:
        return LargeTileGroup(chart);
      default:
        return SmallTileGroup(chart);
    }
  }
}