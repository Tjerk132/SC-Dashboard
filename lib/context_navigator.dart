import 'package:flutter/material.dart';

class ContextNavigator {

  static push (BuildContext context, Widget pushTo) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pushTo),
    );
  }
}