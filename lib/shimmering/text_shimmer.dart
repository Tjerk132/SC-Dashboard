import 'package:flutter/material.dart';
import 'package:flutter_test_project/shimmering/skeleton.dart';

class TextShimmer extends StatelessWidget {
  final double height;
  final double width;
  final Alignment alignment;

  TextShimmer({
    this.height = 20,
    this.width = 200,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      alignment: alignment,
      child: Skeleton(
        height: height,
        width: width,
      ),
    );
  }
}
