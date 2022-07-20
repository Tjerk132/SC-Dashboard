import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_project/app/locator.dart';
import 'package:flutter_test_project/models/session/session.dart';
import 'package:flutter_test_project/services/group_type_service.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SessionService {
  final GroupTypeService _groupTypeService = locator<GroupTypeService>();

  late int crossAxisCount;

  List<Session> _sessions = <Session>[];

  Future<void> initialize() async {
    _sessions = await _fetchSessions();
    _groupTypeService.addGroupTypes(
      _sessions
          .map((session) => session.asMap)
          .reduce((map1, map2) => {...map1, ...map2}),
    );
  }

  List<Session> lastSession() {
    List<Session> sessions = _sortByNew(List<Session>.of(_sessions));
    Session lastSession = sessions.first;
    _alignSessionGroups(lastSession);
    return <Session>[lastSession];
  }

  List<Session> sessionsByDate({
    required DateTime start,
    required DateTime end,
  }) {
    List<Session> sessions = _sortByNew(_filterSessionsByDate(start, end));
    sessions.forEach((session) => _alignSessionGroups(session));
    return sessions;
  }

  /// returns the [_sessions] filtered by [start] and [end]
  List<Session> _filterSessionsByDate(DateTime start, DateTime end) {
    return List<Session>.of(_sessions)
        .where((session) =>
            session.date.isAfter(start) && session.date.isBefore(end))
        .toList();
  }

  List<Session> _sortByNew(List<Session> sessions) {
    sessions.sort((a, b) => a.date.compareTo(b.date));
    // reverse sessions to display by new
    return sessions.reversed.toList();
  }

  Session _alignSessionGroups(Session session) {
    if (session.isAligned) {
      return session;
    }
    //only works for an even crossAxisCount
    int remaining = session.occupied % (crossAxisCount ~/ 2);
    // //groups can't be filled up but bottom could be not aligned.
    // if (remaining == 0) {
    //   //check for bottom alignment
    //   //todo doesn't work because of medium tileGroups
    //   if (session.groups.length.isOdd) {
    //     remaining = 4;
    //   }
    // }
    // // tiles do not align completely so insert a tile to align with the size of [remaining]
    if (remaining != 0) {
      session.groups.add(TileGroup.byFactor(
        remaining,
        [Image.asset('lib/assets/smart-clips.png')],
      ));
    }

    session.isAligned = true;
    return session;
  }
}

List<Session> parseSessions(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Session>((json) => Session.fromJson(json)).toList();
}

Future<List<Session>> _fetchSessions() async {
  final response = await rootBundle.loadString('lib/assets/data/sessions.json');

  return compute(parseSessions, response.toString());
}
