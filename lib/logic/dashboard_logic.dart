import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/enums/line_chart_type.dart';
import 'package:flutter_test_project/enums/pie_chart_type.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/data/image_dao.dart';
import 'package:flutter_test_project/printers/logger.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';
import '../models/tile_size.dart';
import '../models/tile_state.dart';

class DashboardLogic {
  Logger logger = new Logger(name: DashboardLogic, timedPrinting: true);

  final int crossAxisCount;
  int occupied = 0;

  List<TileState> _states;
  ImageDao dao;

  final List<int> singularSizes = [2, 1, 2, 4, 2, 4, 2];

  final List<dynamic> types = [
    PieChartType.progression,
    PieChartType.donut,
    null,
    LineChartType.sales,
    LineChartType.sales,
    null,
    PieChartType.divided,
    null,
    LineChartType.sales,
    LineChartType.sales,
  ];


  DashboardLogic(int count, this.crossAxisCount) {
    this._states = List.generate(
      count,
      (index) => new TileState(index),
    );
    this.dao = new ImageDao();
  }

  TileGroup createTile(List<Chart> charts, int singularSize, int index) {
    TileGroup group = TileGroup.singularSizeFactory(charts, singularSize);
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
    for (int i = 0; i < _states.length;) {
      // print('=${await getChartByIndex(jsonCharts, i, 1, types[i])}');
      int singularSize = singularSizes.elementAt(groups.length);

      TileGroup g;
      //only small tileGroup can have multiple charts
      if (singularSize == 1) {
        g = await createSmallGroup(jsonCharts, singularSize, i);
        i += 4;
      }
      else {
        dynamic type = types[i];
        Chart chart = await getChartByIndex(jsonCharts, i, singularSize, type);
        g = createTile([chart], singularSize, i);
        i++;
      }
      groups.add(g);
    }
    groups.insert(0, TitleTileGroup('Afgelopen weken'));
    groups.insert(4, TitleTileGroup('Afgelopen jaar'));
    return groups;
  }

  Future<TileGroup> createSmallGroup(String jsonCharts, int singularSize, int currentIndex) async {
    TileGroup g;
    List<Chart> charts = new List<Chart>();
    for (int j = 0; j < 4; ++j) {
      int index = currentIndex + j;
      dynamic type = types[index];
      charts.add(await getChartByIndex(jsonCharts, index, singularSize, type));
    }
    g = createTile(charts, singularSize, currentIndex);
    return g;
  }

  Future<Chart> getChartByIndex(
      String jsonCharts, int index, int singularSize, dynamic chartType) async {
    if (index >= _states.length) {
      print('index $index exceeds max ${_states.length}');
      return null;
    }
    Map<String, dynamic> props = json.decode(jsonCharts)['chart $index'];
    ChartType type = ChartType.values.firstWhere((e) => e.toString().split('.').last == props['type']);
    return await type.instance(props, singularSize, chartType);
  }

  Future<List<NetworkImage>> getImages(List<TileSize> sizes) async =>
      await dao.getImages(sizes);

  void setAlignedVertical(int index, bool alignVertical) =>
      _states[index].alignVertical = alignVertical;

  void setTileGroup(int index, TileGroup group) => _states[index].group = group;
}
