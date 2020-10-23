import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/logic/dashboard_logic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  final int crossAxisCount = 8;
  final int tileCount = 12;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  // final List<TileSize> _sizes = TileSize.createSizes(57).toList();
  List<ChartType> _types;
  DashboardLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = new DashboardLogic(widget.tileCount, widget.crossAxisCount);
    _types = _logic.getChartTypes(widget.tileCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: StaggeredGridView.countBuilder(
        physics: BouncingScrollPhysics(),
        // addRepaintBoundaries: false,
        // addAutomaticKeepAlives: true,
        // primary: true,
        itemCount: widget.tileCount,
        crossAxisCount: widget.crossAxisCount,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        itemBuilder: (context, index) {
          return _logic.createTile(_types[index], index, widget.tileCount);
        },
        staggeredTileBuilder: (int index) =>
            StaggeredTile.fit(widget.crossAxisCount ~/ 2),
        // new StaggeredTile.fit(_logic.getTileType(index)?.occupiedSpace ?? 2),
      ),
    );
  }
}
