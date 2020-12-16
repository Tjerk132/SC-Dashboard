import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';

abstract class Chart extends StatefulWidget {
  final ChartType type;
  final String title;
  final String subTitle;

  @mustCallSuper
  Chart({
    Key key,
    this.type,
    this.title,
    this.subTitle,
  }) : super(key: key);

}
