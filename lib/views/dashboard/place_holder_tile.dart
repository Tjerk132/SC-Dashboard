import 'package:flutter/material.dart';

class PlaceholderTile extends StatelessWidget {
  const PlaceholderTile({this.size});

  final int size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('size of placeholder: $size'),
    );
  }
}
