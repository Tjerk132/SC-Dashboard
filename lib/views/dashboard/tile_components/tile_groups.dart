import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

class SmallTileGroup extends TileGroup {
  SmallTileGroup(List<Chart> charts)
      : super.fromDimensions(charts,
            singularSize: 1, occupationSize: 4, horizontal: 2, vertical: 2);
}

class MediumTileGroup extends TileGroup {
  MediumTileGroup(List<Chart> charts)
      : super.fromDimensions(charts,
            singularSize: 2, occupationSize: 2, horizontal: 2, vertical: 1);
}

class LargeTileGroup extends TileGroup {
  LargeTileGroup(List<Chart> charts)
      : super.fromDimensions(charts,
            singularSize: 4, occupationSize: 4, horizontal: 1, vertical: 1);
}
