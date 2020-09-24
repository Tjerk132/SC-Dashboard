import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  const Tile(this.index, this.image);

  final int index;
  final NetworkImage image;

  @override
  State<StatefulWidget> createState() => _TileState(image);
}

class _TileState extends State<Tile> {
  _TileState(this._image);

  NetworkImage _image;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: FadeInImage(
              fit: BoxFit.cover,
              image: _image,
              placeholder: AssetImage('lib/assets/youtube.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
