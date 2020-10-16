import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';

class TileGroupCreator {

  int size;

  TileGroupCreator(this.size);

  TileGroup group(ChartType type) {
    switch (size) {
      case 1:
        return SmallTileGroup(type);
      case 2:
        return MediumTileGroup(type);
      case 3:
        //todo implement logger
        print('Warn [No tile could be created with the given size $size]');
      //todo 3sized tile (tbi) & change alignVertical for this case
        return null;
      case 4:
        return LargeTileGroup(type);
      default:
        return SmallTileGroup(type);
    }
  }
}