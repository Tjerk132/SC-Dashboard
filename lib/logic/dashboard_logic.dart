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

  Future<List<Session>> lastSession(BuildContext context) async {
    //only fetch data if it is not already fetched before
    if (_sessions.isEmpty) {
      await fetchSessions(context);
    }
    List<Session> sessions = sortByNew(
      List<Session>.of(_sessions)
    );
    Session lastSession = sessions.last;
    this.alignSessionGroups(lastSession);
    return <Session>[lastSession];
  }

  Future<List<Session>> sessions(
    BuildContext context, {
    @required DateTime start,
    @required DateTime end,
  }) async {
    //only fetch data if it is not already fetched before
    if (_sessions.isEmpty) {
      await fetchSessions(context);
    }
    List<Session> sessions = sortByNew(
      this.filterSessionsByDate(start, end)
    );
    // print(sessions.length);
    sessions.forEach((session) => this.alignSessionGroups(session));
    return sessions;
  }

  Future<void> fetchSessions(BuildContext context) async {
    //load all charts for the local file
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString('lib/enums/samples.json');
    Map<String, dynamic> sessions = await compute(decodeCharts, jsonData);
    this.assignSessionData(sessions);
  }

  void assignSessionData(Map<String, dynamic> sessions) {
    for (int i = 0; i < sessions.length; ++i) {
      Map<String, dynamic> sessionData = sessions['$i'];
      Session session = new Session(sessionData['date']);
      session.retrieveGroups(sessionData);

      occupied += session.occupied;
      _sessions.add(session);
    }
  }

  /// returns the [_sessions] filtered by [start] and [end]
  List<Session> filterSessionsByDate(
    DateTime start,
    DateTime end,
  ) {
    return List<Session>.of(_sessions)
        .where((session) =>
            session.date.isAfter(start) && session.date.isBefore(end))
        .toList();
  }

  List<Session> sortByNew(List<Session> sessions) {
    sessions.sort((a, b) => a.date.compareTo(b.date));
    // reverse sessions to display by new
    return sessions.reversed.toList();
  }

  Session alignSessionGroups(Session session) {
    if(session.isAligned) {
      return session;
    }
    //only works for an even crossAxisCount
    int remaining = session.occupied % (crossAxisCount ~/ 2);
    //groups can't be filled up but bottom could be not aligned.
    if(remaining == 0) {
      //check for bottom alignment
      if(session.groups.length.isOdd) {
        remaining = 4;
      }
    }
    // tiles do not align completely so insert a tile to align with the size of [remaining]
    if (remaining != 0) {
      session.addGroup(TileGroup.singularSizeFactory(
          [Image.asset('lib/assets/smart-clips.png')], remaining));
    }
    session.isAligned = true;
    return session;
  }

// Future<List<NetworkImage>> getImages(List<Size> sizes) async =>
//     await dao.getImages(sizes);
}

Map<String, dynamic> decodeCharts(String jsonCharts) => json.decode(jsonCharts);