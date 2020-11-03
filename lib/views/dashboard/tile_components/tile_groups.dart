import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

class SmallTileGroup extends TileGroup {
  SmallTileGroup(Chart chart)
      : super.fromDimensions(chart,
            singularSize: 1, occupationSize: 4, horizontal: 2, vertical: 2);
}

class MediumTileGroup extends TileGroup {
  MediumTileGroup(Chart chart)
      : super.fromDimensions(chart,
            singularSize: 2, occupationSize: 2, horizontal: 2, vertical: 1);
}

class LargeTileGroup extends TileGroup {
  LargeTileGroup(Chart chart)
      : super.fromDimensions(chart,
            singularSize: 4, occupationSize: 4, horizontal: 1, vertical: 1);
}

class PlaceholderTileGroup extends TileGroup {
  PlaceholderTileGroup(int size)
      : super.fromSize(null,
            singularSize: size, occupationSize: size, size: size);
}
