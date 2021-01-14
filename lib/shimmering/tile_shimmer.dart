import 'package:flutter/material.dart';
import 'package:flutter_test_project/shimmering/skeleton.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';

class TileShimmer extends StatefulWidget {

  @override
  _TileShimmerState createState() => _TileShimmerState();
}

class _TileShimmerState extends State<TileShimmer> {
  @override
  Widget build(BuildContext context) {
    return LargeTileGroup([Skeleton()]);
  }
}
