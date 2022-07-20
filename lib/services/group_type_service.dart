import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GroupTypeService {
  Map<TileGroupType, List<Widget>> _groupTypes = Map.fromEntries(
    TileGroupType.values.map((type) => MapEntry(type, <Widget>[])),
  );

  void addGroupTypes(Map<TileGroupType, List<Widget>> groupTypes) {
    groupTypes.keys.forEach((type) {
      List<Widget> existing =
          groupTypes.entries.firstWhere((entry) => entry.key == type).value;
      _groupTypes.update(type, (value) => [...value, ...existing]);
    });
  }

  TileGroupType getByChart(Chart chart) => _groupTypes.entries
      .firstWhere((entry) => entry.value.contains(chart))
      .key;
}
