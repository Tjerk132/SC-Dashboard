import 'package:flutter/material.dart';
import 'package:flutter_test_project/shimmering/skeleton.dart';

class TextShimmer extends StatelessWidget {
  TextShimmer({this.height = 20, this.width = 200});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Skeleton(height: height, width: width),
    );
  }
}