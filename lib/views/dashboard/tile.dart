import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/tilesize.dart';

class Tile extends StatefulWidget {
  const Tile(this.index, this.size, this.image);

  final int index;
  final TileSize size;
  final NetworkImage image;

  @override
  State<StatefulWidget> createState() => _TileState(image);
}

class _TileState extends State<Tile>  {

  _TileState(this._image);

  NetworkImage _image;

  @override
  Widget build(BuildContext context) {

    return new Card(
      child: new Column(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              FadeInImage(
                image: _image,
                placeholder: AssetImage('lib/assets/youtube.jpg'),
              )
            ]
          ),
          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Image number ${widget.index}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Width: ${widget.size.width}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  'Height: ${widget.size.height}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ]
      ),
    );

//                  child: Image.network('https://picsum.photos/${widget.size.width}/${widget.size.height}/', fit: BoxFit.cover,
//                     width: double.maxFinite,
//                     loadingBuilder:(BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
//                     if (loadingProgress == null) {
////                       _animationController.animateTo(1.0);
//                       return Padding(
//                         padding: EdgeInsets.all(8.0),
//                        child:child,
////                         child: FadeTransition(child: child, opacity: _animationController),
//                       );
//                     }
//                     else {
//                       if(loadingProgress.expectedTotalBytes == null) {
//                         progress = 0.0;
////                         _animationController.animateTo(0.0);
//                       }
//                       else progress = loadingProgress.cumulativeBytesLoaded /
//                           loadingProgress.expectedTotalBytes;
//                     }
//                     return Center(
//                       child: CircularProgressIndicator(
//                         value: loadingProgress.expectedTotalBytes != null ?
//                         progress
//                             : null,
//                       ),
//                     );
//                     },
//                   ),


  }
}


final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);