import 'package:flutter/material.dart';
import '../tile.dart';

abstract class TileGroup extends StatefulWidget {
  TileGroup(this.image, {this.horizontal, this.vertical});

  final int horizontal;
  final int vertical;
  final NetworkImage image;

  @override
  _TileGroupState createState() => _TileGroupState();
}

class _TileGroupState extends State<TileGroup> {
  bool alignVertical;

  @override
  void initState() {
    super.initState();
    alignVertical = widget.horizontal != widget.vertical;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Column(
          children: List.generate(
            widget.vertical,
            (index) => Row(
              mainAxisSize: MainAxisSize.max,
              children: List.generate(
                alignVertical ? 1 : widget.horizontal,
                (index) => Expanded(
                  flex: 1,
                  child: Tile(
                      index: index,
                      image: widget.image),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
