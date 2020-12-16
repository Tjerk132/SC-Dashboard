import 'dart:math';

import 'package:flutter_test_project/enums/tile_group_type.dart';

class SizeGenerator {
  final List<int> availableSizes;
  List<int> sizes;
  Random r;

  SizeGenerator({
    this.availableSizes = const <int>[1, 2, 4],
  }) {
    this.sizes = new List<int>();
    this.r = new Random();
  }

  int nextSize(ChartType type, int index, int remaining) {
    //todo check if refactor is necessary
    if (type == ChartType.Text) {
      return 2;
    }
    else
      return calculateNextSize(index, remaining);
  }

  int calculateNextSize(int index, int remaining) {
    /// [remaining] is smaller then 4 so no small group can
    /// be completed. remove 1 from available sizes if present
    if (remaining < 4) {
      List<int> available = List<int>.of(availableSizes);
      available.remove(1);
      return available[r.nextInt(available.length)];
    }
    int next = fillUpTileSize(index);
    sizes.add(next);
    return next;
  }

  /// returns the size to fill up the current tile or returns
  /// a new random size from [availableSizes]
  int fillUpTileSize(int index) {
    //start with new random size and adjust if necessary
    int next = availableSizes[r.nextInt(availableSizes.length)];
    if (sizes.isNotEmpty) {
      int previous = sizes[index - 1];
      // either a small group is completed or the current tile is part of a small tile group
      if (previous == 1 && !isSmallGroupCompleted(index)) {
        next = 1;
      }
      if (previous == 2 && !isMediumGroupCompleted(index)) {
        next = 2;
      }
    }
    return next;
  }

  /// small group is completed when the last
  /// 4 tiles before [index] are all of size 1
  /// (already checked for first with [previous]
  bool isSmallGroupCompleted(int index) {
    if (sizes.length >= 4) {
      if (sizes[index - 2] == 1 &&
          sizes[index - 3] == 1 &&
          sizes[index - 4] == 1) {
        return true;
      }
    }
    return false;
  }

  bool isMediumGroupCompleted(int index) {
    if (sizes.length >= 2) {
      if (sizes[index - 2] == 2) {
        return true;
      }
    }
    return false;
  }
}
