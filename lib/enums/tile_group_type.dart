import 'package:flutter/material.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

enum TileGroupType {
  small,
  medium,
  large,
}

extension ChartGroupTypeExtension on TileGroupType {

  TileGroup instance(List<Widget> children) {
    switch (this) {
      case TileGroupType.small:
        return TileGroup.small(children);
      case TileGroupType.medium:
        return TileGroup.medium(children);
      case TileGroupType.large:
        return TileGroup.large(children);
    }
  }

  int get childCount {
    switch (this) {
      case TileGroupType.small:
        return 4;
      case TileGroupType.medium:
        return 2;
      case TileGroupType.large:
        return 1;
    }
  }

  int get factor {
    switch (this) {
      case TileGroupType.small:
        return 1;
      case TileGroupType.medium:
        return 2;
      case TileGroupType.large:
        return 4;
    }
  }
}
