import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/bar_chart.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/charts/line_chart.dart';
import 'package:flutter_test_project/models/charts/pie_chart.dart';
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

  ImageDao _dao;
  List<TileState> _states;

  final int crossAxisCount;
  int occupied = 0;
  Random r;

  bool createPlaceholder = false;

  DashboardLogic(int sizesLength, this.crossAxisCount) {
    this._states = List.generate(
      sizesLength,
      (index) => new TileState(index),
    );
    this._dao = new ImageDao();
    this.r = new Random();
  }

  TileGroup createTile(Chart chart, int index, int sizesLength) {
    setStateHasData(index);
    if (index == sizesLength - 1) {
      checkLastTile(chart);
    }
    return createNewTile(index, chart);
  }

  TileGroup createNewTile(int index, Chart chart) {
    //random between tiles of size 1x1 to 2x2
    TileGroup group = TileGroup.dimensionFactory(chart,
        horizontal: r.intMaxMin(2), vertical: r.intMaxMin(2));

    occupied += group.occupiedSpaces;

    if(group.alignVertically) {
      _states[index].alignVertical = true;
    }
    return group;
  }

  void checkLastTile(Chart chart) {
    int size = occupied % crossAxisCount;
    logger.log('space for last tile is $size');
    TileGroup group = TileGroup.sizeFactory(chart, size: size);
    //no group could be created with the remaining space
    if (group == null) {
      createPlaceholder = true;
      logger.log('a placeholder will be created with size $size');
    }
  }

  TileGroup createLastTile() {
    int size = occupied % crossAxisCount;
    int horizontal = size ~/ 2;
    int vertical = size - horizontal;
    return PlaceholderTileGroup(horizontal, vertical);
  }

  Widget createShimmer(int index) {
    setTileShimmering(index, true);
    return TileShimmer(
        height: 600,
        imageShimmerRatio: 0.45,
        titleShimmer: true,
        textShimmers: 2);
  }

  Future<List<Chart>> getCharts(int sizesLength) async {
    List<Chart> charts = new List<Chart>();
    for (int i = 0; i < sizesLength; i+=3) {
        charts.add(new BarChartGraph());
        charts.add(new LineChartGraph());
        charts.add(new PieChartGraph());
    }
    return charts;
  }


  Future<List<NetworkImage>> getImages(List<TileSize> sizes) async =>
      await _dao.getImages(sizes);

  bool getIsShimmering(int index) => _states[index].shimmering;

  void setTileShimmering(int index, bool shimmer) =>
      _states[index].shimmering = shimmer;

  bool getIsAlignedVertical(int index) => _states[index].alignVertical;

  void setStateHasData(int index) => _states[index].setHasData();
}
