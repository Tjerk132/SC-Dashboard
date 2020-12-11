import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/logic/size_generator.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/session/session_title.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';
import '../../views/dashboard/tile_components/tile_group.dart';

class Session {
  TitleTileGroup title;
  List<TileGroup> _groups;
  DateTime date;
  int occupied = 0;

  Session(String date) {
    this._groups = new List<TileGroup>();
    this.date = DateTime.parse(date);
    this.title = TitleTileGroup(SessionTitle(
      date: this.date,
      insets: EdgeInsets.only(left: 10.0, top: 6.0),
    ));
  }

  Future<void> retrieveGroups(Map<String, dynamic> session, SizeGenerator sizeGenerator) async {
    int sessionItemCount = session.values.length;

    /// 0 is the date that's used to create a [TitleTileGroup] so start with index 1
    for (int i = 1; i < sessionItemCount; i++) {
      Map<String, dynamic> sessionData = session.values.elementAt(i);

      int remaining = sessionItemCount - i;
      ChartType type = typeFromJson(sessionData);
      int singularSize = sizeGenerator.nextSize(type, i, remaining);
      //todo fix chart type for pies
      Chart chart = await type.instance(sessionData, singularSize, null);

      TileGroup g = TileGroup.singularSizeFactory([chart], singularSize);
      occupied += g.occupationSize;
      _groups.add(g);
    }
    // print(_groups);
  }

  ChartType typeFromJson(Map<String, dynamic> chart) => ChartType.values
      .firstWhere((e) => e.toString().split('.').last == chart['type'],
          orElse: () => ChartType.Text);

  List<TileGroup> get groups => _groups;
}
