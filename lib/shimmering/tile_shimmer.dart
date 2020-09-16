import 'package:flutter/material.dart';
import 'package:flutter_test_project/shimmering/skeleton.dart';

class TileShimmer extends StatefulWidget {
  const TileShimmer({this.height = 400});

  final double height;

  @override
  _TileShimmerState createState() => _TileShimmerState();
}

class _TileShimmerState extends State<TileShimmer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: EdgeInsets.only(bottom: 4.0),
      child: Column(
        children: <Widget>[
          Skeleton(width: 380.0, height: widget.height - 90),
          Spacer(flex: 2),
          Skeleton(width: 180.0),
          Spacer(flex: 1),
          Skeleton(width: 120.0),
          Spacer(flex: 1),
          Skeleton(width: 120.0),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(3),
        bottomRight: Radius.circular(3)
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
      )
    );
  }
}
