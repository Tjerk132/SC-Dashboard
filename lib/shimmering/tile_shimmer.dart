import 'package:flutter/material.dart';
import 'package:flutter_test_project/shimmering/skeleton.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

class TileShimmer extends StatefulWidget {
  final TileGroup group;

  TileShimmer({
    @required int size,
  }) : group = TileGroup.singularSizeFactory(List.filled(size, Skeleton()), size);

  @override
  _TileShimmerState createState() => _TileShimmerState();
}

class _TileShimmerState extends State<TileShimmer> {
  @override
  Widget build(BuildContext context) => widget.group;
}
