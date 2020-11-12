import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/logic/dashboard_logic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test_project/shimmering/tile_shimmer.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';

import 'clock/clock.dart';

class Dashboard extends StatefulWidget {
  final int crossAxisCount = 8;

  //orig=7 increase to add tiles or titles
  final int tileCount = 9;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // final List<TileSize> _sizes = TileSize.createSizes(57).toList();
  DashboardLogic _logic;

  @override
  void initState() {
    super.initState();
    //orig=10
    _logic = new DashboardLogic(10, widget.crossAxisCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: [
            Clock(
              textStyle: TextStyle(fontSize: 20),
            ),
            IconButton(
              iconSize: 30,
              icon: Icon(Icons.account_circle_rounded),
              onPressed: null,
            ),
          ],
        ),
        body: FutureBuilder<List<TileGroup>>(
          future: _logic.groups(context),
          builder: (BuildContext context, AsyncSnapshot<List<TileGroup>> snapshot) {
            return StaggeredGridView.countBuilder(
              physics: BouncingScrollPhysics(),
              itemCount: widget.tileCount,
              crossAxisCount: widget.crossAxisCount,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              itemBuilder: (BuildContext context, int index) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return TileShimmer(
                      height: 600,
                      imageShimmerRatio: 0.45,
                      textShimmers: 2,
                      titleShimmer: true,
                    );
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return snapshot.data[index];
                }
              },
              staggeredTileBuilder: (int index) => StaggeredTile.fit(
                  snapshot.hasData
                      ? snapshot.data[index] is TitleTileGroup ? 8 : 4
                      : 4),
            );
          },
        )
        // new StaggeredTile.fit(_logic.getTileType(index)?.occupiedSpace ?? 2),
        );
  }
}
