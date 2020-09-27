import 'package:flutter/material.dart';
import 'package:flutter_test_project/shimmering/skeleton.dart';
import 'package:flutter_test_project/shimmering/text_shimmer.dart';

class TileShimmer extends StatefulWidget {
  TileShimmer(
      {this.height = 400,
      this.imageShimmerRatio = 0.3,
      this.titleShimmer = false,
      this.textShimmers = 2}) {
    if (this.imageShimmerRatio < 0.0 || this.imageShimmerRatio > 1.0) {
      throw new ArgumentError(
          'variable imageShimmerRatio must be between 0.0 and 1.0');
    }
  }

  final double height;
  final double imageShimmerRatio;
  final int textShimmers;
  final bool titleShimmer;

  @override
  _TileShimmerState createState() => _TileShimmerState();
}

class _TileShimmerState extends State<TileShimmer> {

  double _imageShimmerHeight;
  int _textShimmers;

  @override
  void initState() {
    super.initState();
    _imageShimmerHeight = widget.height * widget.imageShimmerRatio;
//    spacerHeight = widget.height * 0.02;
    _textShimmers = widget.textShimmers;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: widget.height,
      padding: EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Skeleton(height: _imageShimmerHeight, width: size.width),
          widget.titleShimmer
              ? TextShimmer(height: 25, width: size.width * 0.2)
              : SizedBox(),
          ...List.generate(
            _textShimmers,
            (index) => new TextShimmer(width: size.width * 0.4),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        ),
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
