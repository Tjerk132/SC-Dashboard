import 'package:flutter/material.dart';
import '../tile.dart';

abstract class TileComponent extends StatefulWidget {
  TileComponent(this.image, {this.horizontal, this.vertical});

  final int horizontal;
  final int vertical;
  final NetworkImage image;

  @override
  _TileComponentState createState() => _TileComponentState();
}

class _TileComponentState extends State<TileComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: List.generate(
          widget.vertical,
          (index) => Row(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(
              widget.horizontal,
              (index) => Expanded(
                flex: 1,
                child: Tile(index, widget.image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
