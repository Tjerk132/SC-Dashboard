import 'package:flutter/material.dart';
import 'package:flutter_test_project/logic/size_generator.dart';
import 'package:flutter_test_project/shimmering/tile_shimmer.dart';

class ShimmerGrid extends StatefulWidget {
  final int count;
  final int crossAxisCount;
  final SizeGenerator sizeGenerator;

  ShimmerGrid({
    Key key,
    this.count = 4,
    this.crossAxisCount = 1,
    List<int> availableSizes,
  })  : sizeGenerator = new SizeGenerator(availableSizes: availableSizes),
        super(key: key);

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
      children: List<TileShimmer>.generate(widget.count, (index) {
        int size = widget.sizeGenerator.calculateNextSize(index, widget.count - index);
        return TileShimmer(size: size);
      }),
    );
  }
}
