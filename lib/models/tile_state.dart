import 'dart:core';

import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:flutter_test_project/utility/utility.dart';

class TileState {
  int index;
  bool alignVertical;
  bool shimmering;
  bool hasData;
  TileGroup group;

  TileState(
    this.index, {
    //initial align unset is false
    this.alignVertical = false,
    this.shimmering = true,
    this.hasData = false,
  });

  void setHasData() {
    this.shimmering = false;
    this.hasData = true;
  }

  @override
  String toString() {
    return allProperties({
      'index': index,
      'alignVertical': alignVertical,
      'shimmering': shimmering,
      'hasData': hasData,
      'group': group
    });
  }
}
