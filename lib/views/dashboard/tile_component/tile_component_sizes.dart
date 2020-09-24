import 'package:flutter/material.dart';
import 'package:flutter_test_project/views/dashboard/tile_component/tile_component.dart';

class TileSmall extends TileComponent {
  TileSmall(NetworkImage image) : super(image, horizontal: 1, vertical: 1);
}

class TileMedium extends TileComponent {
  TileMedium(NetworkImage image) : super(image, horizontal: 2, vertical: 1);
}

class TileLarge extends TileComponent {
  TileLarge(NetworkImage image) : super(image, horizontal: 2, vertical: 2);
}
