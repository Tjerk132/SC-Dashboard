import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/utility/utility.dart';
import 'package:flutter_test_project/data/image_dao.dart';
import 'package:flutter_test_project/printers/logger.dart';
import 'package:flutter_test_project/shimmering/tile_shimmer.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';

import '../models/tile_size.dart';
import '../models/tile_state.dart';

class DashboardLogic {
  Logger logger = new Logger(name: DashboardLogic, timedPrinting: true);

  final int crossAxisCount;
  int occupied = 0;

  List<TileState> _states;
  ImageDao _dao;
  Random r;

  //todo as tile groups are now saved as states check if tiles can fit with each other by looking at their neighbours of each tile when returning

  DashboardLogic(int count, this.crossAxisCount) {
    this._states = List.generate(
      count,
      (index) => new TileState(index),
    );
    this._dao = new ImageDao();
    this.r = new Random();
  }

  TileGroup createTile(ChartType type, int index, int count) {
    setHasData(index);
    return isLastTile(index, count)
        ? createLastTile(index, type)
        : createNewTile(index, type);
  }

  TileGroup createNewTile(int index, ChartType type) {
    //random between tiles of size 1x1 to 2x2
    TileGroup group = TileGroup.dimensionFactory(type,
        horizontal: r.intMaxMin(2), vertical: r.intMaxMin(2));

    print('randomized $group for index $index with chart $type');

    occupied += group.occupationSize;
    setTileType(index, group);

    if (group.alignVertically) {
      setAlignedVertical(index, true);
    }
    return group;
  }

  TileGroup createLastTile(int index, ChartType type) {
    int size = occupied % crossAxisCount;
    if (size != 0) {
      TileGroup group = TileGroup.sizeFactory(type, size: size);

      /// no group could be created with the remaining space if group is null
      if (group == null) {
        logger.log('a placeholder will be created with size $size');
        group = createPlaceholder(size);
      }
      else {
        logger.log('group is created with leftover size $size');
      }
      setTileType(index, group);
      return group;
    }
    // size = 0 so the tiles align, should never reach this return
    return null;
  }

  PlaceholderTileGroup createPlaceholder(int size) {
    return PlaceholderTileGroup(size);
  }

  TileShimmer createShimmer(int index) {
    setTileShimmering(index, true);
    return TileShimmer(
        height: 600,
        imageShimmerRatio: 0.45,
        titleShimmer: true,
        textShimmers: 2);
  }

  Future<List<ChartType>> getCharts(int count) async {
    return [
      for (int i = 0; i < count; i += Chart.length)
        ...Chart.types()
    ];
  }

  Future<List<NetworkImage>> getImages(List<TileSize> sizes) async =>
      await _dao.getImages(sizes);

  bool getIsShimmering(int index) => _states[index].shimmering;

  void setTileShimmering(int index, bool shimmer) =>
      _states[index].shimmering = shimmer;

  bool getIsAlignedVertical(int index) => _states[index].alignVertical;

  void setAlignedVertical(int index, bool alignVertical) =>
      _states[index].alignVertical = alignVertical;

  void setHasData(int index) => _states[index].setHasData();

  void setTileType(int index, TileGroup group) => _states[index].group = group;

  TileGroup getTileGroup(int index) => _states[index].group;

  bool isLastTile(int index, int count) => index == count - 1;
}
