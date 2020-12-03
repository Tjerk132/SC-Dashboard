import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/enums/pie_chart_type.dart';
import 'package:flutter_test_project/logic/size_generator.dart';
import 'package:flutter_test_project/models/charts/chart.dart';

// import 'package:flutter_test_project/data/image_dao.dart';
import 'package:flutter_test_project/printers/logger.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

class DashboardLogic {
  Logger logger = new Logger(name: DashboardLogic, timedPrinting: true);

  final int crossAxisCount;
  SizeGenerator sizeGenerator;
  final List<dynamic> types = [
    PieChartType.progression,
    PieChartType.donut,
    null, null, null, null,
    PieChartType.divided,
    null, null, null, null
  ];

  //todo remove (unused)
  int occupied = 0;
  List<TileGroup> _groups;

  // ImageDao dao;

  DashboardLogic(this.crossAxisCount) {
    this._groups = new List<TileGroup>();
    this.sizeGenerator = new SizeGenerator();
    // this.dao = new ImageDao();
  }

  Future<List<TileGroup>> groups(
    BuildContext context, {
    @required DateTime start,
    @required DateTime end,
  }) async {
    //only fetch graphs if they are not already fetched before
    if (_groups.isEmpty) {
      //load all charts for the local file
      String jsonCharts = await DefaultAssetBundle.of(context).loadString('lib/enums/samples.json');
      Map<String, dynamic> charts = await compute(decodeCharts, jsonCharts);
      await getTileGroups(charts);
    }
    List<TileGroup> groups = filterGroupsByDate(start, end);
    int remaining = checkGroupAlignment(groups);
    // tiles do not align completely
    if(remaining != 0) {
      //insert image todo put smartclips image?
      groups.add(TileGroup.singularSizeFactory([Image.asset('lib/assets/youtube.jpg')], remaining));
    }
    return groups;
  }

  Future<void> getTileGroups(Map<String, dynamic> charts) async {
    for (int i = 0; i < charts.length;) {
      int remaining = charts.length - i;
      int singularSize = sizeGenerator.calculateNextSize(_groups.length, remaining);

      TileGroup g;
      //only small tileGroup can have multiple charts
      if (singularSize == 1) {
        g = await createSmallGroup(charts, singularSize, i);
        i += 4;
      }
      else {
        dynamic type = types[i];
        Chart chart = await getGroupTypeByIndex(charts, i, singularSize, type);
        g = createTile([chart], singularSize);
        i++;
      }
      _groups.add(g);
    }
  }

  Future<TileGroup> createSmallGroup(
    Map<String, dynamic> jsonCharts,
    int singularSize,
    int currentIndex,
  ) async {
    List<Chart> charts = new List<Chart>();
    for (int j = 0; j < 4; ++j) {
      int index = currentIndex + j;
      if (index < jsonCharts.length) {
        dynamic type = types[index];
        charts.add(
            await getGroupTypeByIndex(jsonCharts, index, singularSize, type));
      }
    }
    return createTile(charts, singularSize);
  }

  Future<Widget> getGroupTypeByIndex(
    Map<String, dynamic> jsonCharts,
    int index,
    int singularSize,
    dynamic chartType,
  ) async {
    Map<String, dynamic> chart = jsonCharts['$index'];
    TileGroupType type = TileGroupType.values.firstWhere((e) => e.toString().split('.').last == chart['type']);
    return await type.instance(chart, singularSize, chartType);
  }

  TileGroup createTile(List<Chart> charts, int singularSize) {
    TileGroup group = TileGroup.singularSizeFactory(charts, singularSize);
    occupied += group.occupationSize;
    return group;
  }

  List<TileGroup> filterGroupsByDate(
    DateTime start,
    DateTime end,
  ) {
    return List<TileGroup>.of(_groups)
      .where((group) =>
        group.date.isAfter(start) &&
        group.date.isBefore(end))
      .toList();
  }

  int checkGroupAlignment(List<TileGroup> groups) {
    //only works for an even crossAxisCount
    int filteredGroupsOccupied = groups.map((group) => group.occupationSize).reduce((a, b) => a + b);
    int remaining = filteredGroupsOccupied % (crossAxisCount ~/ 2);
    // print('${filteredGroupsOccupied ~/ 4} isOdd? ${(filteredGroupsOccupied ~/ 4).isOdd}');
    // there is no space left to fill up a tile but the tiles do not align in the bottom
    // so create a large tile to align
    if(remaining == 0 && (filteredGroupsOccupied ~/ (crossAxisCount / 2)).isOdd) {
      return 4;
    }
    //else return the remaining space
    return remaining;
  }

// Future<List<NetworkImage>> getImages(Map<int, int> sizes) async =>
//     await dao.getImages(sizes);
}

Map<String, dynamic> decodeCharts(String jsonCharts) => json.decode(jsonCharts);
