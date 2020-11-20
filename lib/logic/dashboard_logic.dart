import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/enums/line_chart_type.dart';
import 'package:flutter_test_project/enums/pie_chart_type.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/data/image_dao.dart';
import 'package:flutter_test_project/printers/logger.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

class DashboardLogic {
  Logger logger = new Logger(name: DashboardLogic, timedPrinting: true);

  final int crossAxisCount;
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

  int occupied = 0;
  List<TileGroup> _groups;
  ImageDao dao;

  DashboardLogic(this.crossAxisCount) {
    this._groups = new List<TileGroup>();
    this.dao = new ImageDao();
  }

  TileGroup createTile(List<Chart> charts, int singularSize) {
    TileGroup group = TileGroup.singularSizeFactory(charts, singularSize);
    // TileGroup.dimensionFactory(chart,
    //     horizontal: r.intMaxMin(2), vertical: r.intMaxMin(2));
    occupied += group.occupationSize;
    return group;
  }

  Future<List<TileGroup>> groups(
    BuildContext context, {
    @required DateTime start,
    @required DateTime end,
  }) async {
    //only fetch graphs if they are not already fetched before
    if (_groups.isEmpty) {
      //load all charts for the local file
      String jsonCharts = await DefaultAssetBundle.of(context)
          .loadString('lib/enums/samples.json');
      Map<String, dynamic> charts = json.decode(jsonCharts);
      await getTileGroups(charts);
    }
    return filterGroupsByDate(start, end);
  }

  getTileGroups(Map<String, dynamic> charts) async {
    for (int i = 0; i < charts.length;) {
      int singularSize = singularSizes.elementAt(_groups.length);
      TileGroup g;
      //only small tileGroup can have multiple charts
      if (singularSize == 1) {
        g = await createSmallGroup(charts, singularSize, i);
        i += 4;
      }
      else {
        dynamic type = types[i];
        Chart chart = await getChartByIndex(charts, i, singularSize, type);
        g = createTile([chart], singularSize);
        i++;
      }
      _groups.add(g);
    }
  }

  Future<TileGroup> createSmallGroup(Map<String, dynamic> jsonCharts, int singularSize, int currentIndex) async {
    TileGroup g;
    List<Chart> charts = new List<Chart>();
    for (int j = 0; j < 4; ++j) {
      int index = currentIndex + j;
      dynamic type = types[index];
      charts.add(await getChartByIndex(jsonCharts, index, singularSize, type));
    }
    g = createTile(charts, singularSize);
    return g;
  }

  Future<Chart> getChartByIndex(Map<String, dynamic> jsonCharts, int index, int singularSize, dynamic chartType) async {
    dynamic chart = jsonCharts['chart $index'];
    ChartType type = ChartType.values.firstWhere((e) => e.toString().split('.').last == chart['type']);
    return await type.instance(chart, singularSize, chartType);
  }

  List<TileGroup> filterGroupsByDate(
    DateTime start,
    DateTime end,
  ) {
    return List<TileGroup>.of(_groups)
        .where((group) =>
            group.charts[0].date.isAfter(start) &&
            group.charts[0].date.isBefore(end))
        .toList();
  }

  // Future<List<NetworkImage>> getImages(Map<int, int> sizes) async =>
  //     await dao.getImages(sizes);
}
