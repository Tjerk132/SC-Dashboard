import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_test_project/enums/pie_chart_type.dart';
import 'package:flutter_test_project/models/session/session.dart';
// import 'package:flutter_test_project/data/image_dao.dart';
import 'package:flutter_test_project/printers/logger.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

class DashboardLogic {
  Logger logger = new Logger(name: DashboardLogic, timedPrinting: true);

  final int crossAxisCount;

  // final List<dynamic> types = [
  //   PieChartType.progression,
  //   PieChartType.donut,
  //   null, null, null, null,
  //   PieChartType.divided,
  //   null, null, null, null
  // ];

  int occupied = 0;
  List<Session> _sessions;
  // ImageDao dao;

  DashboardLogic(this.crossAxisCount) {
    this._sessions = new List<Session>();
    // this.dao = new ImageDao();
  }

  Future<List<Session>> groups(
    BuildContext context, {
    @required DateTime start,
    @required DateTime end,
  }) async {
    //only fetch data if it is not already fetched before
    if (_sessions.isEmpty) {
      //load all charts for the local file
      String jsonData = await DefaultAssetBundle.of(context).loadString('lib/enums/samples.json');
      Map<String, dynamic> sessions = await compute(decodeCharts, jsonData);
      await this.retrieveSessions(sessions);
    }
    List<Session> sessions = this.filterSessionsByDate(start, end);
    sessions.forEach((session) => this.alignSessionGroups(session));
    return sessions;
  }

  Future<void> retrieveSessions(Map<String, dynamic> sessions) async {
    for (int i = 0; i < sessions.length; ++i) {
      Map<String, dynamic> sessionData = sessions['$i'];
      Session session = new Session(sessionData['date']);
      await session.retrieveGroups(sessionData);

      occupied += session.occupied;
      _sessions.add(session);
    }
  }

  // Future<void> getTileGroups(Map<String, dynamic> charts) async {
  //   for (int i = 0; i < charts.length;) {
  //     int remaining = charts.length - i;
  //     int singularSize =
  //         sizeGenerator.calculateNextSize(_groups.length, remaining);
  //
  //     TileGroup g;
  //     //only small tileGroup can have multiple charts
  //     if (singularSize == 1) {
  //       g = await createSmallGroup(charts, singularSize, i);
  //       i += 4;
  //     } else {
  //       dynamic type = types[i];
  //       Chart chart = await jsonToChart(charts, singularSize, type);
  //       g = createTile([chart], singularSize);
  //       i++;
  //     }
  //     _groups.add(g);
  //   }
  // }

  // Future<TileGroup> createSmallGroup(
  //   Map<String, dynamic> jsonCharts,
  //   int singularSize,
  //   int currentIndex,
  // ) async {
  //   List<Chart> charts = new List<Chart>();
  //   for (int j = 0; j < 4; ++j) {
  //     int index = currentIndex + j;
  //     if (index < jsonCharts.length) {
  //       dynamic type = types[index];
  //       charts.add(
  //           await jsonToChart(jsonCharts, singularSize, type));
  //     }
  //   }
  //   return createTile(charts, singularSize);
  // }

  List<Session> filterSessionsByDate(
    DateTime start,
    DateTime end,
  ) {
    return List<Session>.of(_sessions)
        .where((session) =>
            session.date.isAfter(start) && session.date.isBefore(end))
        .toList();
  }

  Session alignSessionGroups(Session session) {
    //only works for an even crossAxisCount
    int remaining = session.occupied % (crossAxisCount ~/ 2);

    /// if [cantFillUpButCanAlign] is true then there is no space left to fill up the last tile
    /// but the tiles do not align in the bottom.
    /// if [cantFillUpButCanAlign] is false then the last tile can be filled up with a size
    /// of [remaining]
    bool cantFillUpButCanAlign = (remaining == 0 && (session.occupied ~/ (crossAxisCount / 2)).isOdd);
    int size = cantFillUpButCanAlign ? 0 : remaining;

    // tiles do not align completely so insert a tile to align with the size of [remaining]
    if (size != 0) {
      session.addGroup(TileGroup.singularSizeFactory(
          [Image.asset('lib/assets/smart-clips.png')], size));
    }
    return session;
  }

// Future<List<NetworkImage>> getImages(List<Size> sizes) async =>
//     await dao.getImages(sizes);
}

Map<String, dynamic> decodeCharts(String jsonCharts) => json.decode(jsonCharts);
