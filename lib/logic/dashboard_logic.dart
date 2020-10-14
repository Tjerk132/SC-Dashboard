import 'dart:math';

import 'package:flutter/material.dart';
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

  DashboardLogic(int sizesLength, this.crossAxisCount) {
    this._states = List.generate(
      sizesLength,
      (index) => new TileState(index),
    );
    this._dao = new ImageDao();
    this.r = new Random();
  }

  TileGroup createTile(Chart chart, int index, int count) {
    setHasData(index);
    return isLastTile(index, count)
        ? createLastTile(index, chart)
        : createNewTile(index, chart);
  }

  TileGroup createNewTile(int index, Chart chart) {
    //random between tiles of size 1x1 to 2x2
    TileGroup group = TileGroup.dimensionFactory(chart,
        horizontal: r.intMaxMin(2), vertical: r.intMaxMin(2));

    print('randomed $group for index $index with chart $chart');

    occupied += group.occupiedSpace;
    setTileType(index, group);

    if (group.alignVertically) {
      setAlignedVertical(index, true);
    }
    return group;
  }

  TileGroup createLastTile(int index, Chart chart) {
    int size = occupied % crossAxisCount;
    if (size != 0) {
      TileGroup group = TileGroup.sizeFactory(chart, size: size);

      /// no group could be created with the remaining space if group is null
      if (group == null) {
        logger.log('a placeholder will be created with size $size');
        group = createPlaceholder(size);
      } else {
        logger.log('group is created with leftover size $size');
      }
      setTileType(index, group);
      return group;
    }
    // size = 0 so the tiles align, should never reach this return
    return null;
  }

  PlaceholderTileGroup createPlaceholder(int size) {
    int horizontal = size ~/ 2;
    int vertical = size - horizontal;
    return PlaceholderTileGroup(horizontal, vertical);
  }

  TileShimmer createShimmer(int index) {
    setTileShimmering(index, true);
    return TileShimmer(
        height: 600,
        imageShimmerRatio: 0.45,
        titleShimmer: true,
        textShimmers: 2);
  }

  Future<List<Chart>> getCharts(int count) async {
    List<int> indexes = new List.generate(count, (index) => index);
    return <Chart>[
      for (int i = 0; i < count; i += Chart.count)
        ...Chart.types(
          //generate charts with indexes
          List<int>.of(
            indexes.getRange(i, i + Chart.count),
          ),
        ).values
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

  TileGroup getTileType(int index) => _states[index].group;

  bool isLastTile(int index, int count) => index == count - 1;
}
