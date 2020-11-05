import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/data/image_dao.dart';
import 'package:flutter_test_project/printers/logger.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import '../models/tile_size.dart';
import '../models/tile_state.dart';

class DashboardLogic {
  Logger logger = new Logger(name: DashboardLogic, timedPrinting: true);

  final int crossAxisCount;
  int occupied = 0;

  List<TileState> _states;
  ImageDao dao;
  Random r;

  //todo as tile groups are now saved as states check if tiles can fit with each other by looking at their neighbours of each tile when returning
  //this depends on tod.o in TileGroup

  DashboardLogic(int count, this.crossAxisCount) {
    this._states = List.generate(
      count,
      (index) => new TileState(index),
    );
    this.dao = new ImageDao();
    this.r = new Random();
  }

  TileGroup createTile(Chart chart, int singularSize, int index) {

    TileGroup group = TileGroup.singularSizeFactory(chart, singularSize);
    // TileGroup.dimensionFactory(chart,
    //     horizontal: r.intMaxMin(2), vertical: r.intMaxMin(2));
    // print('randomized $group for index $index with chart $chart');
    occupied += group.occupationSize;
    setTileGroup(index, group);
    if (group.alignVertically) {
      setAlignedVertical(index, true);
    }
    return group;
  }

  Future<List<TileGroup>> groups(BuildContext context) async {

    //load all charts for the local file
    String jsonCharts = await DefaultAssetBundle.of(context)
        .loadString('lib/enums/samples.json');

    List<TileGroup> groups = new List<TileGroup>();
    for (int i = 0; i < _states.length; ++i) {
      //get chart by index
      Map<String, dynamic> props = json.decode(jsonCharts)['chart $i'];

      // get type for props
      ChartType  type = ChartType.values.firstWhere((e) => e.toString().split('.').last == props['type']);
      int singularSize = [1, 2, 4][r.nextInt(3)];
      Chart chart = await type.instance(props, singularSize);

      TileGroup g = createTile(chart, singularSize, i);
      groups.add(g);
    }
    return groups;
  }

  Future<List<NetworkImage>> getImages(List<TileSize> sizes) async =>
      await dao.getImages(sizes);


  void setAlignedVertical(int index, bool alignVertical) =>
      _states[index].alignVertical = alignVertical;

  void setTileGroup(int index, TileGroup group) => _states[index].group = group;
}
