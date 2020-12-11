import 'dart:math';

import 'package:flutter_test_project/enums/tile_group_type.dart';

class SizeGenerator {
  final List<int> availableSizes = [1, 2, 4];
  List<int> sizes;
  Random r;

  SizeGenerator() {
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
    // return 2 or 4 if small group can't be completed
    if(remaining < 4) {
      return [2,4][r.nextInt(2)];
    }
    if (sizes.isNotEmpty) {
      int previous = sizes[index - 1];
      // either a small group is completed or the current tile is part of a small tile group
      if (previous == 1) {
        if (!isSmallGroupCompleted(index)) {
          sizes.add(1);
          return 1;
        }
      }
    }
    //random new size
    int size = availableSizes[r.nextInt(availableSizes.length)];
    sizes.add(size);
    return size;
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
}
