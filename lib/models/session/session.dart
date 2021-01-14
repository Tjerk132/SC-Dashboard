import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/logic/size_generator.dart';
import 'package:flutter_test_project/models/session/session_title.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';
import '../../views/dashboard/tile_components/tile_group.dart';

class Session {
  TitleTileGroup title;
  List<TileGroup> _groups;
  DateTime date;
  int _occupied = 0;
  bool _isAligned = false;

  SizeGenerator _sizeGenerator;

  Session(String date) {
    this._groups = new List<TileGroup>();
    this._sizeGenerator = new SizeGenerator();
    this.date = DateTime.parse(date);
    this.title = TitleTileGroup(SessionTitle(
      date: this.date,
      insets: EdgeInsets.only(left: 10.0, top: 6.0),
    ));
  }

  void retrieveGroups(Map<String, dynamic> session) {
    /// the date is used to create a [TitleTileGroup], remove to start with index 0
    session.remove("date");
    int sessionItemCount = session.values.length;

    for (int i = 0; i < sessionItemCount;) {
      int remaining = sessionItemCount - i;
      int singularSize = _sizeGenerator.calculateNextSize(i, remaining);

      List<Widget> children = new List<Widget>();
      if (singularSize == 1) {
        children.addAll(
          retrieveSmallGroupCharts(
              session.values.toList().sublist(i, i + 4), singularSize),
        );
        i += 4;
      }
      else {
        children.add(
          retrieveChart(session.values.elementAt(i), singularSize),
        );
        i++;
      }
      TileGroup g = TileGroup.singularSizeFactory(children, singularSize);
      this.addGroup(g);
    }
  }

  Widget retrieveChart(
    Map<String, dynamic> sessionData,
    int singularSize,
  ) {
    ChartType type = ChartType.values.firstWhere(
        (e) => e.toString().split('.').last == sessionData['type'],
        orElse: () => ChartType.Text);
    //todo fix chart type for pies (null) or remove completely
    return type.instance(sessionData, singularSize/*, null*/);
  }

  List<Widget> retrieveSmallGroupCharts(
    List<dynamic> sessionsData,
    int singularSize,
  ) {
    return <Widget>[
      for (Map<String, dynamic> sessionData in sessionsData)
        retrieveChart(sessionData, singularSize)
    ];
  }

  void addGroup(TileGroup tileGroup) {
    this._groups.add(tileGroup);
    this._occupied += tileGroup.occupationSize;
  }

  List<TileGroup> get groups => _groups;

  int get occupied => _occupied;

  bool get isAligned => _isAligned;

  set isAligned(bool isAligned) => this._isAligned = isAligned;
}
