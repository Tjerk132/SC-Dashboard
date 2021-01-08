import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test_project/models/session/session.dart';

class SessionGrid extends StatefulWidget {
  final Session session;
  final int crossAxisCount;

  SessionGrid({
    Key key,
    this.session,
    this.crossAxisCount,
  }) : super(key: key);

  @override
  _SessionGridState createState() => _SessionGridState();
}

class _SessionGridState extends State<SessionGrid> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: widget.crossAxisCount,
      itemCount: widget.session.groups.length,
      itemBuilder: (BuildContext context, int index) =>
          widget.session.groups[index],
      staggeredTileBuilder: (int index) => StaggeredTile.fit(widget.crossAxisCount ~/ 2),
    );
  }
}
