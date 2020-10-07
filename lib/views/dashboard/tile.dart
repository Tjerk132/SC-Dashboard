import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart.dart';

class Tile extends StatefulWidget {
  const Tile({this.chart});

  final Chart chart;

  @override
  State<StatefulWidget> createState() => _TileState(chart);
}

class _TileState extends State<Tile> {
  _TileState(this._chart);

  Chart _chart;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
      ),
      clipBehavior: Clip.antiAlias,
//      elevation: 4,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: _chart,
        // child: FadeInImage(
        //   fit: BoxFit.cover,
        //   image: _image,
        //   placeholder: AssetImage('lib/assets/placeholder.jpg'),
        // ),
      ),
    );
  }
}
