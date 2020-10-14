import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

class SmallTileGroup extends TileGroup {
  SmallTileGroup(Chart chart)
      : super.fromDimensions(chart, horizontal: 2, vertical: 2);
}

class MediumTileGroup extends TileGroup {
  MediumTileGroup(Chart chart)
      : super.fromDimensions(chart, horizontal: 2, vertical: 1);
}

class LargeTileGroup extends TileGroup {
  LargeTileGroup(Chart chart)
      : super.fromDimensions(chart, horizontal: 1, vertical: 1);
}

class PlaceholderTileGroup extends TileGroup {
  PlaceholderTileGroup(int horizontal, int vertical)
      : super.fromDimensions(null, horizontal: horizontal, vertical: vertical);
}
