import 'dart:core';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test_project/device_type.dart';
import 'package:flutter_test_project/logic/dashboard_logic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test_project/models/session/session.dart';
import 'package:flutter_test_project/providers/time_filter_provider.dart';
import 'package:flutter_test_project/shimmering/tile_shimmer.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_groups.dart';
import 'package:flutter_test_project/views/dashboard/time_filter.dart';
import 'package:provider/provider.dart';

import 'clock/clock.dart';

class Dashboard extends StatefulWidget {
  final int crossAxisCount = DeviceType().isPhone ? 4 : 8;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardLogic _logic;
  Future<List<Session>> _future;
  TimeFilterProvider provider;

  @override
  void initState() {
    _logic = new DashboardLogic(widget.crossAxisCount);

    provider = context.read<TimeFilterProvider>();
    provider.addListener(providerCallback);

    DateTime now = DateTime.now();
    _future = _logic.groups(
      context,
      start: now.subtract(Duration(days: 7)),
      end: now,
    );
    super.initState();
  }

  @override
  void dispose() {
    provider?.removeListener(providerCallback);
    super.dispose();
  }

  void providerCallback() {
    if (this.mounted) {
      setState(() {
        _future = _logic.groups(
          context,
          start: provider.start,
          end: provider.end,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: <Widget>[
          Clock(
            textStyle: TextStyle(fontSize: 20),
          ),
          Icon(
            Icons.account_circle_rounded,
            size: 30,
          ),
        ],
        bottom: TimeFilter(appBarHeight: AppBar().preferredSize.height),
      ),
      body: FutureBuilder<List<Session>>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<List<Session>> snapshot) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: snapshot.hasData
                  ? snapshot.data
                      .map((session) {
                        return <Widget>[
                          session.title,
                          StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: widget.crossAxisCount,
                            itemCount: session.groups.length,
                            itemBuilder: (BuildContext context, int index) {
                              return session.groups[index];
                            },
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.fit(
                                    session.groups[index] is TitleTileGroup
                                        ? widget.crossAxisCount
                                        : widget.crossAxisCount ~/ 2),
                          )
                        ];
                      })
                      .reduce((value, element) => [...value, ...element])
                      .toList()
                  : <Widget>[
                GridView.count(
                  physics: ScrollPhysics(),
                  crossAxisCount: widget.crossAxisCount ~/ 4,
                  shrinkWrap: true,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 2,
                  children: List<TileShimmer>.generate(
                    6,
                    (index) => TileShimmer(
                      size: [1,4][Random().nextInt(2)],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
