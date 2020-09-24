import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:flutter_test_project/data/image_dao.dart';
import 'package:flutter_test_project/models/tile_size.dart';
import 'package:flutter_test_project/shimmering/tile_shimmer.dart';
import 'package:flutter_test_project/views/dashboard/tile_component/tile_component_sizes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<TileSize> _sizes = TileSize.createSizes(46).toList();

  Future<List<NetworkImage>> getImages() async =>
      await ImageDao().getImages(_sizes);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Dashboard'),
      ),
      body: FutureBuilder<List<NetworkImage>>(
          future: getImages(),
          builder: (context, AsyncSnapshot<List<NetworkImage>> snapshot) {
            return StaggeredGridView.countBuilder(
              physics: BouncingScrollPhysics(),
              addAutomaticKeepAlives: true,
              primary: true,
              itemCount: _sizes.length,
              crossAxisCount: 4,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
//            crossAxisSpacing: Sizing.getSize(mediaQuery, 64),
              itemBuilder: (context, index) {
                if (snapshot.hasData) {
                  NetworkImage image = snapshot.data[index];
                  switch (Random().nextInt(3)) {
                    case 0:
                      return TileSmall(image);
                    case 1:
                      return TileMedium(image);
                    case 2:
                      return TileLarge(image);
                    default:
                      return Text('Cannot find');
                  }
                }
                return TileShimmer();
              },
              staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
            );
          }),
    );
  }
}
