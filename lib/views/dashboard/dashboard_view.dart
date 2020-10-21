import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/chart_type.dart';
import 'package:flutter_test_project/logic/dashboard_logic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  final int crossAxisCount = 8;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final int _tileCount = 12;

  // final List<TileSize> _sizes = TileSize.createSizes(57).toList();

  DashboardLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = new DashboardLogic(_tileCount, widget.crossAxisCount);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Dashboard'),
      ),
      body: FutureBuilder<List<ChartType>>(
        future: _logic.getCharts(_tileCount),
        builder: (context, AsyncSnapshot<List<ChartType>> snapshot) {
          return StaggeredGridView.countBuilder(
            physics: BouncingScrollPhysics(),
            // addAutomaticKeepAlives: true,
            // primary: true,
            itemCount: _tileCount,
            crossAxisCount: widget.crossAxisCount,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            itemBuilder: (context, index) {
              if (snapshot.hasData) {
                return _logic.createTile(
                    snapshot.data[index], index, _tileCount);
              }
              else
                return _logic.createShimmer(index);
            },
            //get the correct fit for each tile by the space they take it (2 for default)
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.fit(widget.crossAxisCount ~/ 2),
            // new StaggeredTile.fit(_logic.getTileType(index)?.occupiedSpace ?? 2),
          );
        },
      ),
    );
  }
}
