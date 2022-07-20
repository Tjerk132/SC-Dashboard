import 'package:flutter/material.dart';

class Tile extends StatefulWidget {

  final Widget child;

  const Tile({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
//      elevation: 4,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: widget.child,
      ),
    );
  }
}
