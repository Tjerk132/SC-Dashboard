import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/logic/type_generator.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/session/session_title.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:collection/collection.dart';

class Session {
  final List<TileGroup> groups = <TileGroup>[];
  final DateTime date;
  final TypeGenerator typeGenerator = TypeGenerator();

  bool isAligned = false;

  Map<TileGroupType, List<Widget>> get asMap =>
      groupBy(groups, (TileGroup group) => group.type).map((type, groups) {
        return MapEntry(
            type,
            groups
                .map((e) => e.children)
                .expand((children) => children)
                .toList());
      });

  TileGroup get title => TileGroup.large([
    SessionTitle(
      date: date,
      insets: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
    )
  ]);

  int get occupied =>
      groups.fold<int>(0, (previous, next) => previous + next.occupationSize);

  Session.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json['date'])
  {
    _groupsFromJson(json['charts']);
  }

  //todo: make toJson, FromJson methods for tileGroup?
  void _groupsFromJson(List<dynamic> chartsJson) {
    List<Chart> charts =
        chartsJson.map<Chart>((json) => Chart.fromJson(json)).toList();

    List<TileGroupType> types = typeGenerator.generateSizes(charts.length);
    //todo: find alternative for loop
    for (int i = 0; i < charts.length;) {
      TileGroupType tileGroupType = types[i];
      // todo: use TileGroupType childCount for fetch?
      List<Chart> children = tileGroupType == TileGroupType.small
          ? charts.sublist(i, i + 4 /*i + tileGroupType.childCount*/)
          : [charts[i]];

      groups.add(tileGroupType.instance(children));
      i += children.length;
    }
  }

  static String groupsToJson(List<TileGroup> tileGroups) {
    //[] around
    return tileGroups
        .map(
            (e) => (e.children as List<Chart>).map((e) => e.toJson()).join(','))
        .join(',');
  }
}
