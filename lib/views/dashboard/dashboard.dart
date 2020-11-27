import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/device_type.dart';
import 'package:flutter_test_project/logic/dashboard_logic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test_project/providers/time_filter_provider.dart';
import 'package:flutter_test_project/shimmering/tile_shimmer.dart';
import 'package:flutter_test_project/views/dashboard/tile_components/tile_group.dart';
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
  Future<List<TileGroup>> _future;
  TimeFilterProvider provider;

  @override
  void initState() {
    _logic = new DashboardLogic(widget.crossAxisCount);

    DateTime now = DateTime.now();
    _future = _logic.groups(
      context,
      start: DateTime(now.year, now.month, now.day),
      end: now,
    );
    provider = context.read<TimeFilterProvider>();
    setProviderListener();
    super.initState();
  }

  @override
  void dispose() {
    provider?.removeListener(providerCallback);
    super.dispose();
  }

  void providerCallback() {
    provider?.addListener(() {
      if(this.mounted) {
        setState(() {
          _future = _logic.groups(
            context,
            start: provider.startDate,
            end: provider.endDate,
          );
        });
      }
    });
  }

  void setProviderListener() {
    provider.addListener(providerCallback);
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
      body: FutureBuilder<List<TileGroup>>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<List<TileGroup>> snapshot) {
          return snapshot.hasData
              ? StaggeredGridView.countBuilder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  crossAxisCount: widget.crossAxisCount,
                  itemBuilder: (BuildContext context, int index) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return TileShimmer(
                          imageShimmerRatio: 0.45,
                          textShimmers: 1,
                          titleShimmer: true,
                        );
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        return snapshot.data[index];
                    }
                  },
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(4),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
