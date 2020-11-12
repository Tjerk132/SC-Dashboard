import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';

class Tile extends StatefulWidget {
  const Tile({
    Key key,
    this.chart,
  }) : super(key: key);

  final Chart chart;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      clipBehavior: Clip.antiAlias,
//      elevation: 4,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: widget.chart,
      ),
      // child: FadeInImage(
      //   fit: BoxFit.cover,
      //   image: _image,
      //   placeholder: AssetImage('lib/assets/placeholder.jpg'),
      // ),
    );
  }
}
