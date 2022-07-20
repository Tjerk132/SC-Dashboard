import 'dart:math';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/utility/utility.dart';

class TypeGenerator {
  final List<TileGroupType> types = <TileGroupType>[];
  final Random r; //2,4,8 ==2

  TypeGenerator([int? seed]) : r = new Random(seed);

  List<TileGroupType> generateSizes(int count) {
    types.clear();
    for (int i = 0; i < count; ++i) {
      TileGroupType next;

      /// the remaining amount is smaller than 4 so no small group can
      /// be completed. remove the small type from the available sizes.
      if (count - i < TileGroupType.small.childCount) {
        next = r.nextObject(List<TileGroupType>.of(TileGroupType.values)
          ..remove(TileGroupType.small));
      } else {
        next = fillUpTile(i);
      }
      types.add(next);
    }
    return types;
  }

  /// Returns the type to fill up the current tile or returns
  /// a new random type from [TileGroupType.values].
  TileGroupType fillUpTile(int index) {
    //start with new random size and adjust if necessary
    if (types.isNotEmpty) {
      // either a small group is completed or the current tile is part of a small tile group
      if (types.last == TileGroupType.small && !isSmallGroupCompleted(index)) {
        return TileGroupType.small;
      }
      if (types.last == TileGroupType.medium && !isMediumGroupCompleted(index)) {
        return TileGroupType.medium;
      }
    }
    return r.nextObject(TileGroupType.values);
  }

  /// A small group is completed when the last 4 tiles
  /// before [index] are all of size 1
  /// (already checked for first with [previous]).
  bool isSmallGroupCompleted(int index) {
    int childCount = TileGroupType.small.childCount;
    if (types.length >= childCount) {
      return types
          .sublist(index - childCount, index - 2)
          .allMatch((type) => type == TileGroupType.small);
    }
    return false;
  }

  /// A medium group is completed when the last 2 tiles
  /// before [index] are of size 2
  /// (already checked for first with [previous]).
  bool isMediumGroupCompleted(int index) {
    int childCount = TileGroupType.medium.childCount;
    if (types.length >= childCount) {
      return types
          .sublist(index - childCount, index - 2)
          .allMatch((type) => type == TileGroupType.medium);
    }
    return false;
  }
}
