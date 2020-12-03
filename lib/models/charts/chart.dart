import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';

abstract class Chart extends StatefulWidget {
  final TileGroupType type;
  final String title;
  final String subTitle;
  final DateTime date;

  Chart({
    Key key,
    this.type,
    this.title,
    this.subTitle,
    this.date,
  }) : super(key: key);

}
