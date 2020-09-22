import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/data/image_dao.dart';
import 'package:flutter_test_project/models/tile_size.dart';
import 'package:flutter_test_project/shimmering/tile_shimmer.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'tile.dart';


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
            addAutomaticKeepAlives: true,
            primary: true,
//            shrinkWrap: true,
            itemCount: _sizes.length,
            crossAxisCount: 4,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            itemBuilder: (context, index) {
              TileSize size = _sizes[index];
              return Center(
                child: snapshot.hasData ?
                  Tile(index, size, snapshot.data[index])
                  :
                  TileShimmer(height: size.height.toDouble()),
              );
            },
            staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
          );
        }
      ),
    );
  }
}
