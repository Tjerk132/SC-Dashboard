import 'package:flutter/material.dart';
import 'package:flutter_test_project/shimmering/skeleton.dart';
import 'package:flutter_test_project/shimmering/text_shimmer.dart';

class TileShimmer extends StatefulWidget {
  final double imageShimmerRatio;
  final int textShimmers;
  final bool titleShimmer;

  TileShimmer({
    this.imageShimmerRatio = 0.3,
    this.titleShimmer = false,
    this.textShimmers = 2,
  }) {
    if (this.imageShimmerRatio < 0.0 || this.imageShimmerRatio > 1.0) {
      throw new ArgumentError('imageShimmerRatio must be between 0.0 and 1.0');
    }
  }

  @override
  _TileShimmerState createState() => _TileShimmerState();
}

class _TileShimmerState extends State<TileShimmer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          widget.titleShimmer
              ? TextShimmer(
            alignment: Alignment.centerLeft,
            height: 35,
            width: size.width * 0.4,
          )
              : SizedBox(),
          Skeleton(
            height: (size.height * 0.5) * widget.imageShimmerRatio,
            width: size.width,
          ),
          Center(
            child: Column(
              children: <Widget>[
                ...List.generate(
                  widget.textShimmers,
                  (index) => TextShimmer(
                    width: double.infinity,
                    height: 90,
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
