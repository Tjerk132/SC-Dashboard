import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/tile_group_data.dart';
import '../tile.dart';

abstract class TileGroup extends StatefulWidget {
//  TileGroup(this.image, {Key key, int horizontal, int vertical, int size})
//      : super(key: key) {
//    if (size != null) {
//      if (horizontal != null || vertical != null) {
//        throw new ArgumentError(
//            'only provide the dimensions or the size of the group');
//      }
//      else
//        this.data = new TileGroupData.fromSize(this.image, size);
//    }
//    else
//      this.data =
//          new TileGroupData.fromDimensions(this.image, horizontal, vertical);
//  }

  TileGroup.fromSize(NetworkImage image, {int size}) {
    this.data = TileGroupData.fromSize(image, size);
  }

  factory TileGroup.sizeFactory(NetworkImage image, {int size}) {
    TileGroupData data = TileGroupData.fromSize(image, size);
    return data.group(data.size);
  }

  TileGroup.fromDimensions(NetworkImage image, {int horizontal, int vertical}) {
    this.data = TileGroupData.fromDimensions(image, horizontal, vertical);
  }

  factory TileGroup.dimensionFactory(NetworkImage image, {int horizontal, int vertical}) {
    TileGroupData data =
        new TileGroupData.fromDimensions(image, horizontal, vertical);
    return data.group(data.size);
  }

  TileGroupData data;

  @override
  _TileGroupState createState() => _TileGroupState();
}

class _TileGroupState extends State<TileGroup> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        widget.data.vertical,
        (index) => Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            widget.data.alignVertically ? 1 : widget.data.horizontal,
            (index) => Expanded(
              flex: 1,
              child: Tile(index: index, image: widget.data.image),
            ),
          ),
        ),
      ),
    );
  }
}
