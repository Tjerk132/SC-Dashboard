import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test_project/models/session/session.dart';

class SessionGrid extends StatefulWidget {
  final Session session;
  final int crossAxisCount;

  SessionGrid({
    Key? key,
    required this.session,
    required this.crossAxisCount,
  }) : super(key: key);

  @override
  _SessionGridState createState() => _SessionGridState();
}

class _SessionGridState extends State<SessionGrid> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: widget.crossAxisCount,
      children: widget.session.groups.map((group) {
        return StaggeredGridTile.fit(
          crossAxisCellCount: widget.crossAxisCount ~/ 2,
          child: group,
        );
      }).toList(),
    );
  }
}
