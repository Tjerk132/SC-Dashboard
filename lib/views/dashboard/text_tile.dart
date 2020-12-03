import 'package:flutter/material.dart';
import 'package:flutter_test_project/views/dashboard/tile.dart';

class TextTile extends StatefulWidget {
  final String content;

  TextTile({
    Key key,
    this.content,
  }) : super(key: key);

  @override
  _TextTileState createState() => _TextTileState();
}

class _TextTileState extends State<TextTile> {
  @override
  Widget build(BuildContext context) {
    return Tile(
      child: Center(
        child: Text(widget.content),
      ),
    );
  }
}
