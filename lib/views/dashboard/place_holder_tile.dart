import 'package:flutter/material.dart';

class PlaceholderTile extends StatelessWidget {
  const PlaceholderTile({this.size});

  final int size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Text('size of placeholder: $size'),
    );
  }
}
