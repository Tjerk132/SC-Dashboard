import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/logic/dashboard_logic.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/tile_size.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  final int crossAxisCount = 4;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<TileSize> _sizes = TileSize.createSizes(57).toList();

  DashboardLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic =
        new DashboardLogic(_sizes.length, widget.crossAxisCount);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Dashboard'),
      ),
      body: FutureBuilder<List<Chart>>(
        future: _logic.getCharts(_sizes.length),
        builder: (context, AsyncSnapshot<List<Chart>> snapshot) {
          return StaggeredGridView.countBuilder(
            physics: BouncingScrollPhysics(),
            addAutomaticKeepAlives: true,
            primary: true,
            itemCount: _sizes.length,
            crossAxisCount: widget.crossAxisCount,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            itemBuilder: (context, index) {
              if (snapshot.hasData) {
                // if(_logic.createPlaceholder) {
                //   return _logic.createLastTile();
                // }
                return _logic.createTile(
                    snapshot.data[index], index, _sizes.length);
              }
              else
                return _logic.createShimmer(index);
            },
            staggeredTileBuilder: (int index) => new StaggeredTile.count(2,
              _logic.getIsAlignedVertical(index) || _logic.getIsShimmering(index) ? 2 : 1),
          );
        },
      ),
    );
  }
}
