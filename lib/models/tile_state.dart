import 'dart:core';

import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:flutter_test_project/utility/utility.dart';

class TileState {
                          //initially unset is false
  TileState(this.index, {this.alignVertical = false, this.shimmering = true});

  int index;
  bool alignVertical;

  //initially always true
  bool shimmering;
  bool hasData = false;

  TileGroup group;

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
