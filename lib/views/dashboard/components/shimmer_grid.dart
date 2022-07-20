import 'package:flutter/material.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';

class ShimmerGrid extends StatefulWidget {
  final int count;
  final int crossAxisCount;

  ShimmerGrid({
    Key? key,
    this.count = 4,
    this.crossAxisCount = 1,
  }) : super(key: key);

  @override
  _ShimmerGridState createState() => _ShimmerGridState();
}

class _ShimmerGridState extends State<ShimmerGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: ScrollPhysics(),
      crossAxisCount: widget.crossAxisCount,
      shrinkWrap: true,
      childAspectRatio: 0.8,
      crossAxisSpacing: 2,
      children: List<TileGroup>.filled(widget.count, TileGroup.asShimmer()),
    );
  }
}
